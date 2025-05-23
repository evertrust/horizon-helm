{{/*
Kubernetes standard labels
*/}}
{{- define "horizon.labels.standard" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
helm.sh/chart: {{ include "common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}

{{/*
Generates a secret key/value or infers the value from an existing secret.
Usage:
{{- include "horizon.generatesecret" (dict "namespace" $namespace "name" $secretName "key" $secretKey "default" $defaultValue) }}
*/}}
{{- define "horizon.generatesecret"}}
{{- $secret := lookup "v1" "Secret" .namespace .name }}

{{- if and $secret $secret.data }}
    {{- if hasKey $secret.data .key }}
    {{- printf "%s: %s" .key (index $secret.data .key) }}
    {{- else }}
    {{- printf "%s: %s" .key (.default | b64enc | quote) }}
    {{- end }}
{{- else }}
    {{- printf "%s: %s" .key (.default | b64enc | quote) }}
{{- end }}
{{- end -}}

{{/*
Either render any template or fetch the secret from the default generated horizon secret
Usage:
{{- include "horizon.rendersecret" (dict "value" $valuesPath "key" $secretKey "context" .) }}
*/}}
{{- define "horizon.rendersecret" -}}
    {{- if .value -}}
      {{- include "common.tplvalues.render" (dict "value" .value "context" .context) }}
    {{- else -}}
valueFrom:
  secretKeyRef:
    name: {{ include "common.names.fullname" .context }}
    key: {{ .key }}
    {{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "horizon.mongodb.fullname" -}}
{{- printf "%s-%s" .Release.Name "mongodb" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Prints either a local or external MongoDB URI.
*/}}
{{- define "horizon.mongodbUri" }}
{{- /* If the mongodb subchart is enabled, we force Horizon to use it. */}}
{{- if .context.Values.mongodb.enabled }}
    {{- if .context.Values.externalDatabase.uri }}
    {{- fail "When mongodb.enabled is set to true, you cannot specify externalDatabase.uri" }}
    {{- else }}
    {{- include "horizon.rendersecret" (dict "key" "mongoUri" "context" .context) }}
    {{- end }}
{{- else }}
    {{- if .context.Values.externalDatabase.uri }}
    {{- include "horizon.rendersecret" (dict "value" .context.Values.externalDatabase.uri "key" "mongoUri" "context" .context) }}
    {{- else }}
    {{- fail "When mongodb.enabled is set to false, you must specify externalDatabase.uri" }}
    {{- end }}
{{- end }}
{{- end }}

{{/*
Prints the appSecret reference.
*/}}
{{- define "horizon.appSecret" }}
{{- include "horizon.rendersecret" (dict "value" .context.Values.appSecret "key" "appSecret" "context" .context) }}
{{- end }}

{{/*
Prints the event seal secret reference.
*/}}
{{- define "horizon.eventSealSecret" }}
{{- include "horizon.rendersecret" (dict "value" .context.Values.events.secret "key" "eventSealSecret" "context" .context) }}
{{- end }}

{{/*
Prints all Horizon allowed hosts.
*/}}
{{- define "horizon.allowedHosts" }}
{{- $allowedHosts := list }}
{{- if .Values.ingress.enabled -}}
  {{- $allowedHosts = append $allowedHosts .Values.ingress.hostname }}
  {{- range .Values.ingress.extraHosts }}
  {{- $allowedHosts = append $allowedHosts .name }}
  {{- end }}
  {{- range .Values.ingress.extraRules }}
  {{- if .host }}
  {{- $allowedHosts = append $allowedHosts .host }}
  {{- end }}
  {{- end }}
{{- end }}
{{- $allowedHosts = concat $allowedHosts .Values.allowedHosts }}
{{- toJson $allowedHosts}}
{{- end }}

{{/*
Prints all Horizon trusted proxies.
*/}}
{{- define "horizon.trustedProxies" }}
    {{- range .Values.trustedProxies -}}
        {{- printf "\"%s\"," . -}}
    {{- end -}}
{{- end }}

{{/*
Prints Horizon loggers.
*/}}
{{- define "horizon.loggingLoggers" }}
    {{- $loggers := list }}
    {{- range .Values.logback.loggers -}}
        {{- $loggers = append $loggers (printf "%s=%s" .name .level) -}}
    {{- end -}}
    {{- join " " $loggers -}}
{{- end }}

{{/*
Prints true if an client certificate auth should be enable, false if not
*/}}
{{- define "horizon.shouldEnableClientCertificateAuth" }}
{{- if .Values.clientCertificateDefaultParsingType }}
  {{- fail "clientCertificateDefaultParsingType is deprecated, use ingress.clientCertificateAuth instead" }}
{{- end }}
{{- if and .Values.clientCertificateHeader .Values.ingress.clientCertificateAuth }}
    {{- fail "clientCertificateHeader and ingress.clientCertificateAuth are mutually exclusive" }}
{{- end }}
{{- if or .Values.clientCertificateHeader .Values.ingress.clientCertificateAuth }}
    {{- print "true" }}
{{- else }}
    {{- print "false" }}
{{- end }}
{{- end }}

{{/*
Prints the client certificate header that should be used by Horizon.
*/}}
{{- define "horizon.clientCertificateHeader" }}
{{- if .context.Values.clientCertificateHeader }}
{{- printf "%s" .context.Values.clientCertificateHeader }}
{{- else }}
{{- if and .context.Values.ingress.type .context.Values.ingress.clientCertificateAuth }}
  {{- if eq .context.Values.ingress.type "nginx" }}
    {{- print "ssl-client-cert" }}
  {{- else if eq .context.Values.ingress.type "traefik" }}
    {{- print "X-Forwarded-Tls-Client-Cert" }}
  {{- else if eq .context.Values.ingress.type "haproxy" }}
    {{- print "X-SSL-Client-DER" }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Prints ingress configuration annotations
*/}}
{{- define "horizon.ingressConfigurationAnnotations" }}
{{- if eq .context.Values.ingress.type "nginx" }}
nginx.ingress.kubernetes.io/server-snippet: |
  large_client_header_buffers 4 64k;
{{- if .context.Values.ingress.clientCertificateAuth }}
  ssl_verify_client optional_no_ca;
{{- end }}
nginx.ingress.kubernetes.io/configuration-snippet: |
{{- if .context.Values.ingress.clientCertificateAuth }}
  proxy_set_header ssl-client-cert $ssl_client_escaped_cert;
{{- end }}
{{- else if eq .context.Values.ingress.type "traefik" }}
traefik.ingress.kubernetes.io/router.tls: "true"
{{ $middlewares := list "https-redirect" }}
{{- if .context.Values.ingress.clientCertificateAuth }}
{{- $middlewares = append $middlewares "client-auth" }}
traefik.ingress.kubernetes.io/router.tls.options: {{ printf "%s-%s-%s@kubernetescrd" .context.Release.Namespace (include "common.names.fullname" .context) "client-auth" }}
{{- end }}
traefik.ingress.kubernetes.io/router.middlewares: {{ range $i, $middleware := $middlewares }}
{{- if $i }}, {{ end }}{{ printf "%s-%s-%s@kubernetescrd" $.context.Release.Namespace (include "common.names.fullname" $.context) $middleware }}
{{- end }}
{{ else if eq .context.Values.ingress.type "haproxy" }}
{{- else }}
{{- fail "Unsupported ingress type. Accepted values are: nginx, traefik, haproxy" }}
{{- end }}
{{- end }}


{{/*
Prints the actual installed version on the cluster
*/}}
{{- define "horizon.installedVersion" }}
{{- $deployment := (lookup (include "common.capabilities.deployment.apiVersion" .) "Deployment" .Release.Namespace (include "common.names.fullname" .)) }}
{{- if and $deployment $deployment.metadata $deployment.metadata.labels }}
    {{- index $deployment.metadata.labels "app.kubernetes.io/version" }}
{{- end }}
{{- end }}

{{/*
Prints true if an upgrade job should run, false if not.
*/}}
{{- define "horizon.shouldRunUpgrade" }}
{{- if .Values.upgrade.force }}
    {{- print "true" }}
{{- else if not .Release.IsUpgrade }}
    {{- print "false" }}
{{- else if not .Values.upgrade.enabled }}
    {{- print "false" }}
{{- else }}
    {{- $version := (include "horizon.installedVersion" .) }}
    {{- if and $version (not (eq $version .Chart.AppVersion))}}
        {{- print "true" }}
    {{- else }}
        {{- print "false" }}
    {{- end }}
{{- end }}
{{- end }}

{{/*
Returns the proper service account name depending if an explicit service account name is set
in the values file. If the name is not set it will default to either horizon.fullname if serviceAccount.create
is true or default otherwise.
*/}}
{{- define "horizon.serviceAccountName" -}}
    {{- if .Values.serviceAccount.create -}}
        {{- default (include "common.names.fullname" .) (print .Values.serviceAccount.name) -}}
    {{- else -}}
        {{- default "default" (print .Values.serviceAccount.name) -}}
    {{- end -}}
{{- end -}}

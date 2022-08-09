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
    {{- if .Values.ingress.enabled -}}
        {{- printf "\"%s\"," .Values.ingress.hostname -}}
    {{- end -}}
    {{- range .Values.ingress.extraHosts -}}
        {{- printf "\"%s\"," .name -}}
    {{- end -}}
    {{- range .Values.allowedHosts -}}
        {{- printf "\"%s\"," . -}}
    {{- end -}}
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
Prints ingress configuration annotations
*/}}
{{- define "horizon.ingressConfigurationAnnotations" }}
{{- if eq .context.Values.ingress.type "nginx" }}
nginx.ingress.kubernetes.io/app-root: /ui#/ra
nginx.ingress.kubernetes.io/server-snippet: |
  large_client_header_buffers 4 64k;
{{- if .context.Values.ingress.clientCertificateAuth }}
  ssl_verify_client optional_no_ca;
{{- end }}
nginx.ingress.kubernetes.io/configuration-snippet: |
{{- if .context.Values.ingress.clientCertificateAuth }}
  proxy_set_header X-Forwarded-Tls-Client-Cert $ssl_client_escaped_cert;
{{- end }}
{{- end }}
{{- if and (eq .context.Values.ingress.type "traefik") }}
traefik.ingress.kubernetes.io/router.tls: "true"
{{ $middlewares := list "app-root" "https-redirect" }}
{{- if .context.Values.ingress.clientCertificateAuth }}
{{- $middlewares = append $middlewares "client-auth" }}
{{- $middlewares = append $middlewares "client-parsing" }}
traefik.ingress.kubernetes.io/router.tls.options: {{ printf "%s-%s-%s@kubernetescrd" .context.Release.Namespace (include "common.names.fullname" .context) "client-auth" }}
{{- end }}
traefik.ingress.kubernetes.io/router.middlewares: {{ range $i, $middleware := $middlewares }}
{{- if $i }}, {{ end }}{{ printf "%s-%s-%s@kubernetescrd" $.context.Release.Namespace (include "common.names.fullname" $.context) $middleware }}
{{- end }}
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
{{- if not .Release.IsUpgrade }}
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
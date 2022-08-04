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
    {{- range .Values.ingress.hosts -}}
        {{- printf "\"%s\"," .host -}}
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
Prints all Horizon trusted proxies.
*/}}
{{- define "horizon.traefikCrd" }}
    {{- printf "%s-%s-%s@kubernetescrd" .context.Release.Namespace (include "common.names.fullname" .context) .name }}
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
{{- if .context.Values.ingress.clientCertificateAuth }}
traefik.ingress.kubernetes.io/router.tls.options: {{ template "horizon.traefikCrd" (dict "context" .context "name" "client-auth" )}}
traefik.ingress.kubernetes.io/router.middlewares: {{ template "horizon.traefikCrd" (dict "context" .context "name" "client-auth" )}}, {{ template "horizon.traefikCrd" (dict "context" .context "name" "app-root" )}}, {{ template "horizon.traefikCrd" (dict "context" .context "name" "https-redirect" )}}
{{- else }}
traefik.ingress.kubernetes.io/router.middlewares: {{ template "horizon.traefikCrd" (dict "context" .context "name" "app-root" )}}, {{ template "horizon.traefikCrd" (dict "context" .context "name" "https-redirect" )}}
{{- end }}
{{- end }}
{{- end }}
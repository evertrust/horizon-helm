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
Prints either a local or external MongoDB URI.
*/}}
{{- define "horizon.mongodbUri" }}
{{- /* If the mongodb subchart is enabled, we force Horizon to use it. */}}
{{- if .context.Values.temporaryDatabase.enabled }}
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
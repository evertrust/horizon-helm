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
Labels used on immutable fields such as deploy.spec.selector.matchLabels or svc.spec.selector
{{ include "common.labels.matchLabels" (dict "customLabels" .Values.podLabels "context" $) -}}

We don't want to loop over custom labels appending them to the selector
since it's very likely that it will break deployments, services, etc.
However, it's important to overwrite the standard labels if the user
overwrote them on metadata.labels fields.
*/}}
{{- define "horizon.labels.matchLabels" -}}
{{- if and (hasKey . "customLabels") (hasKey . "context") -}}
{{ merge (pick (include "common.tplvalues.render" (dict "value" .customLabels "context" .context) | fromYaml) "app.kubernetes.io/name" "app.kubernetes.io/instance" "app.kubernetes.io/component") (dict "app.kubernetes.io/name" (include "common.names.name" .context) "app.kubernetes.io/instance" .context.Release.Name ) | toYaml }}
{{- else -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- end -}}
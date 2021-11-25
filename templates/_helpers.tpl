{{- define "horizon.app" -}}
{{ printf "%s-%s" .Release.Name "app" }}
{{- end -}}

{{- define "horizon.deployment" -}}
{{ printf "%s-%s" .Release.Name "deployment" }}
{{- end -}}

{{- define "horizon.baseLabels" -}}
app.kubernetes.io/app: horizon
app.kubernetes.io/instance: {{ printf "%s-%s" "horizon" .Release.Name }}
{{- end -}}

{{- define "horizon.labels" -}}
{{- include "horizon.baseLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}
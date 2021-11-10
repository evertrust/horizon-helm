{{- define "horizon.app" -}}
{{ printf "%s-%s" .Release.Name "app" }}
{{- end -}}

{{- define "horizon.deployment" -}}
{{ printf "%s-%s" .Release.Name "deployment" }}
{{- end -}}

{{- define "horizon.labels" -}}
app.kubernetes.io/app: horizon
app.kubernetes.io/instance: {{ printf "%s-%s" "horizon" .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}
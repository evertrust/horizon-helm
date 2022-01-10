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


{{- define "horizon.mongodbUri" }}
{{- include "horizon.rendersecret" (dict "value" .context.Values.externalDatabase.uri "key" "mongoUri" "context" .context) }}
{{- end }}

{{- define "horizon.appSecret" }}
{{- include "horizon.rendersecret" (dict "value" .context.Values.appSecret "key" "appSecret" "context" .context) }}
{{- end }}

{{- define "horizon.allowedHosts" }}
    {{- range .Values.ingress.hosts -}}
        {{- printf "\"%s\"," .host -}}
    {{- end -}}
    {{- range .Values.allowedHosts -}}
        {{- printf "\"%s\"," . -}}
    {{- end -}}
{{- end }}
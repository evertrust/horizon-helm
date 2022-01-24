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
{{- define "horizon.rendersecret" -}}
    {{- if .value }}
      {{- include "common.tplvalues.render" (dict "value" .value "context" $) }}
    {{- else }}
valueFrom:
  secretKeyRef:
    name: {{ include "common.names.fullname" $ }}
    key: {{ .key }}
    {{- end }}
{{- end -}}


{{- define "horizon.mongodb.uri" }}
{{- template "horizon.rendersecret" (dict "value" .Values.externalDatabase.uri "key" "mongoUri") }}
{{- end }}

{{- define "horizon.appSecret" }}
{{- template "horizon.rendersecret" (dict "value" .Values.appSecret "key" "appSecret") }}
{{- end }}

{{- define "horizon.vaultMasterPassword" }}
{{- $vaultPasswordKey := (printf ".Values.vaults.%s.master_password" .vault) }}
{{- $vaultSecretKey := (printf "%sVaultMasterPassword" .vault) }}
{{- template "horizon.rendersecret" (dict "value" (tpl $vaultPasswordKey) "key" $vaultSecretKey) }}
{{- end }}
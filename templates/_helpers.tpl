{{- define "horizon.mongodb.uri" }}
    {{- if .Values.externalDatabase.uri }}
      {{- toYaml .Values.externalDatabase.uri }}
    {{- else }}
      {{- printf "mongodb://%s:%s@horizon-mongodb.%s.svc.cluster.local/%s?authSource=admin" .Values.mongodb.auth.rootUser .Values.mongodb.auth.rootPassword .Release.Namespace .Values.mongodb.database }}
    {{- end }}
{{- end }}
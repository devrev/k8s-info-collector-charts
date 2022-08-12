{{- define "service.name" -}}
{{- $baseName:= .Chart.Name -}}
{{- $name := (default $baseName .Values.fullnameOverride ) | trunc 63 | trimSuffix "-" -}}
{{- printf "%s" $name }}
{{- end }}

{{- define "service.fullname" -}}
{{-  if .Values.prefixReleaseName -}}
  {{- printf "%s" (printf "%s-%s" .Release.Name (include "service.name" . )) | trunc 63 | trimSuffix "-" }}
{{- else -}}
  {{- printf "%s" (include "service.name" . ) }}
{{- end  -}}
{{- end }}

{{- define "k8s-info-cron-service.serviceAccountName" -}}
{{-  if .Values.serviceAccount.name -}}
  {{- printf "%s" .Values.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
  {{- printf "%s" (include "service.name" . ) }}
{{- end  -}}
{{- end }}

{{- define "k8s-info-cron-service.secretName" -}}
{{-  if .Values.secret.name -}}
  {{- printf "%s" .Values.secret.name | trunc 63 | trimSuffix "-" }}
{{- else -}}
  {{- printf "%s" (include "service.name" . ) }}
{{- end  -}}
{{- end }}

{{- define "k8s-info-cron-service.k8sVersionCheck" -}}
{{- if and (eq (int .Capabilities.KubeVersion.Major) 1) (le (int .Capabilities.KubeVersion.Minor) 24) }}
  {{- printf "%t" true }}
{{- else -}}
  {{- printf "%t" false }}
{{- end  -}}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define ".Values.clusterAgent.name" -}}
{{- default .Chart.Name .Values.clusterAgent.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define ".Values.clusterAgent.fullname" -}}
{{- if .Values.clusterAgent.fullnameOverride }}
{{- .Values.clusterAgent.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.clusterAgent.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define ".Values.clusterAgent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define ".Values.clusterAgent.labels" -}}
helm.sh/chart: {{ include ".Values.clusterAgent.chart" . }}
{{ include ".Values.clusterAgent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define ".Values.clusterAgent.selectorLabels" -}}
app.kubernetes.io/name: {{ include ".Values.clusterAgent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define ".Values.clusterAgent.serviceAccountName" -}}
{{- if .Values.clusterAgent.serviceAccount.create }}
{{- default (include ".Values.clusterAgent.fullname" .) .Values.clusterAgent.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.clusterAgent.serviceAccount.name }}
{{- end }}
{{- end }}

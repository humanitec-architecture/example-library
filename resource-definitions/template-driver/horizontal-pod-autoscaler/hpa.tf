resource "humanitec_resource_definition" "hpa" {
  driver_type = "humanitec/template"
  id          = "hpa"
  name        = "hpa"
  type        = "horizontal-pod-autoscaler"
  driver_inputs = {
    values_string = jsonencode({
      "resId" = "$${context.res.id}"
      "templates" = {
        "init"      = <<END_OF_TEXT
{{ $defaultMaxReplicas := 3 }}
{{ $defaultMinReplicas := 2 }}
{{ $absoluteMaxReplicas := 10 }}
{{ $defaultTargetUtilizationPercent := 80 }}

workload: {{ if regexMatch "modules\\.[a-z0-9-]+\\.externals" .driver.values.resId }}
  {{- index (splitList "." .driver.values.resId) 1 | toRawJson }}
{{- else }}
  {{- cat "A horizontal-pod-autoscaler must be added as a private resource dependency. ID:" .driver.values.resId | fail }}
{{- end }}

maxReplicas: {{ .resource.maxReplicas | default $defaultMaxReplicas | min $absoluteMaxReplicas }}
minReplicas: {{ .resource.minReplicas | default $defaultMinReplicas }}
targetCPUUtilizationPercentage: {{ .resource.targetCPUUtilizationPercentage | default $defaultTargetUtilizationPercent }}
END_OF_TEXT
        "manifests" = <<END_OF_TEXT
hpa.yaml:
  location: namespace
  data:
    apiVersion: autoscaling/v2
    kind: HorizontalPodAutoscaler
    metadata:
      name: {{ .init.workload }}-hpa
    spec:
      maxReplicas: {{ .init.maxReplicas }}
      metrics:
      - resource:
          name: cpu
          target:
            averageUtilization: {{ .init.targetCPUUtilizationPercentage }}
            type: Utilization
        type: Resource
      minReplicas: {{ .init.minReplicas }}
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: {{ .init.workload }}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "hpa_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.hpa.id

}

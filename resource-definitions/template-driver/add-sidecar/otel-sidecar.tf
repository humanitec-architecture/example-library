resource "humanitec_resource_definition" "otel-sidecar" {
  driver_type = "humanitec/template"
  id             = "otel-sidecar"
  name           = "otel-sidecar"
  type           = "workload"
  driver_inputs  = {
    values_string  = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
{{- /*
    The "update" output is passed into the corresponding "update" output of the "workload" Resource Type.
*/ -}}
update:
  {{- /*
    Add the variable OTEL_EXPORTER_OTLP_ENDPOINT to all containers
  */ -}}
  {{- range $containerId, $value := .resource.spec.containers }}
  - op: add
    path: /spec/containers/{{ $containerId }}/variables/OTEL_EXPORTER_OTLP_ENDPOINT
    value: http://localhost:4317
  {{- end }}
END_OF_TEXT
        "manifests" = {
          "sidecar.yaml" = {
            "location" = "containers"
            "data" = <<END_OF_TEXT
{{- /*
  The Open Telemetry container as a sidecar in the workload
*/ -}}
command:
  - "/otelcol"
  - "--config=/conf/otel-agent-config.yaml"
image: otel/opentelemetry-collector:0.94.0
name: otel-agent
resources:
  limits:
    cpu: 500m
    memory: 500Mi
  requests:
    cpu: 100m
    memory: 100Mi
ports:
- containerPort: 55679 # ZPages endpoint.
- containerPort: 4317 # Default OpenTelemetry receiver port.
- containerPort: 8888  # Metrics.
env:
  - name: GOMEMLIMIT
    value: 400MiB
volumeMounts:
- name: otel-agent-config-vol
  mountPath: /conf
END_OF_TEXT
          }
          "sidecar-volume.yaml" = {
            "location" = "volumes"
            "data" = <<END_OF_TEXT
{{- /*
  A volume that is used to surface the config file
*/ -}}
configMap:
  name: otel-agent-conf-{{ .id }}
  items:
    - key: otel-agent-config
      path: otel-agent-config.yaml
name: otel-agent-config-vol
END_OF_TEXT
          }
          "otel-config-map.yaml" = {
            "location" = "namespace"
            "data" = <<END_OF_TEXT
{{- /*
  The config file for the Open Telemetry agent. Notice that it's name includes the GUResID
*/ -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: otel-agent-conf-{{ .id }}
  labels:
    app: opentelemetry
    component: otel-agent-conf
data:
  otel-agent-config: |
    receivers:
      otlp:
        protocols:
          grpc:
            endpoint: localhost:4317
          http:
            endpoint: localhost:4318
    exporters:
      otlp:
        endpoint: "otel-collector.default:4317"
        tls:
          insecure: true
        sending_queue:
          num_consumers: 4
          queue_size: 100
        retry_on_failure:
          enabled: true
    processors:
      batch:
      memory_limiter:
        # 80% of maximum memory up to 2G
        limit_mib: 400
        # 25% of limit up to 2G
        spike_limit_mib: 100
        check_interval: 5s
    extensions:
      zpages: {}
    service:
      extensions: [zpages]
      pipelines:
        traces:
          receivers: [otlp]
          processors: [memory_limiter, batch]
          exporters: [otlp]
END_OF_TEXT
          }
        }
      }
    })
  }
}



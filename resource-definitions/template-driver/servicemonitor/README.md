This section contains an example Resource Definition using the [Template Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/template/) for provisioning Prometheus [ServiceMonitor](https://prometheus-operator.dev/docs/developer/getting-started/#using-servicemonitors) for your Workloads.

The solution consists of one `workload` Resource Definitions injecting its associated `ServiceMonitor` manifest if a `service` is defined in the Score file.

Note that the port on the generated `ServiceMonitor` will be taken by the first `port` of the `service`'s `ports`. Default port value to `8080`. You can adapt these parts to meet with your own requirements.
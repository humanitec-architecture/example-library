Define how a service for the Workload is configured.

Refer to the [service feature](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humanitecservice) for configuration details.

You may optionally set annotations and labels on the Kubernetes `Service` object through a Score extension file.

Other workloads of the same Application may access a workload's service through a `service` Resource declared in Score. That resource's `name` output will resolve to the Kubernetes-internal DNS name of the other workload's service. See the Score files for the specific setup.
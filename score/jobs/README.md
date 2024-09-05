You can set any property of the [Kubernetes JobSpec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/job-v1/#JobSpec), except `selector` and `template`, on the Kubernetes `Job` object through a Score extension file for your workload.

Refer to the [Job feature](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humanitecjob) for configuration details.

The Score extension file specifies the `humanitec/default-job` Workload Profile to use which supports the feature.

You can apply properties to the Pods created for the CronJob accurding to the [Kubernetes PodSpec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#PodSpec), except `containers`. Refer to the [Pod feature](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humanitecpod) for configuration details.
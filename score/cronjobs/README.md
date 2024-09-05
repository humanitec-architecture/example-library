Define `schedules` under which the CronJob should run as a [Kubernetes CronJob](https://kubernetes.io/docs/concepts/Workloads/controllers/cron-jobs/).

Refer to the [schedules feature](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humanitecschedules) for configuration details.

The Score extension file specifies the `humanitec/default-cronjob` Workload Profile to use which supports the feature.

You can set any property of the [Kubernetes JobSpec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/cron-job-v1/#CronJobSpec), except `selector` and `template`, on the Kubernetes `Job` objects created from the CronJob through a Score extension file for your workload.

Refer to the [CronJob feature](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humaniteccronjob) for configuration details.

You can apply properties to the Pods created for the CronJob accurding to the [Kubernetes PodSpec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#PodSpec), except `containers`. Refer to the [Pod feature](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humanitecpod) for configuration details.
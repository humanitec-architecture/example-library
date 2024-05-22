Define volumes and volume mounts for a Workload.

Volume mounts are declared in the `volumes` section of the Score file.

Volumes that are not provisioned through the [Humanitec Resources System](https://developer.humanitec.com/platform-orchestrator/reference/resource-types#volume), that are of type `emptyDir` or `projected`, are declared in the `volumes` section of the Score extension file. All other volume types are declared in the `extraVolumes` section of the Score extension file. For mounting them, specify `volumes.<name>`, as the `source` in the volume mount in the Score file.

For volumes of type `emptyDir` (example-1) or `projected` (example-2), there is a special syntax to follow for the `default module` workload profile. If the projected volume includes a configMap entry, then the name of the configMap must follow the `<<workloadname>>-configmap` convention. The `extraVolumes` (example-3) section relies on the standard Kubernetes syntax for volume definition.

Volumes that are provisioned through the Resources system are not declared in the Score or Score extension file. For mounting them, specify their Resource ID, e.g. `shared.nfs-share`, as the `source` in the volume mount in the Score file.

Refer to the [volumes](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humanitecvolumes) and [volume-mounts](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humaniteccontainers---volume-mounts) features for configuration details.
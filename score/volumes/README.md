Define volumes and volume mounts for a Workload.

Volume mounts are declared in the `volumes` section of the Score file.

Volumes that are not provisioned through the [Humanitec Resources System](https://developer.humanitec.com/platform-orchestrator/reference/resource-types#volume), e.g. `emptyDir`, are declared in the `volumes` section of the Score extension file. For mounting them, specify `volumes.<name>`, as the `source` in the volume mount in the Score file.

Volumes that are provisioned through the Resources system are not declared in the Score or Score extension file. For mounting them, specify their Resource ID, e.g. `shared.nfs-share`, as the `source` in the volume mount in the Score file.

Refer to the [volumes](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humanitecvolumes) and [volume-mounts](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humaniteccontainers---volume-mounts) features for configuration details.
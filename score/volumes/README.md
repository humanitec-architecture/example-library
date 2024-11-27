Define volumes and volume mounts for a Workload.

Volume mounts are declared in the `volumes` section of the Score file. There should be a resource of type `volume` defined in your resource definitions, [see examples here](https://developer.humanitec.com/examples/resource-definitions/volume-pvc/volumes/).

One trick is that the content of `source` in the `volume` section should only reference the name of the resource, not an output. For example: `${resources.my-volume}`.

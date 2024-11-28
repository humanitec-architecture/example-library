This section contains Resource Definition examples for handling Kubernetes [Volumes](https://kubernetes.io/docs/concepts/storage/volumes) by using the [`template`](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/template/) Driver to configure your own `PersistentVolume` implementation. You can [see this other example](https://developer.humanitec.com/examples/resource-definitions/volume-pvc/volumes/) if you want to use the `volume-pvc` Driver.

You will find two examples:
- `volume-emptydir` - in order to inject an `emptyDir` `volume` in a Workload for any request of a `volume` resource with the `class` `ephemeral`.
- `volume-nfs` - in order to create the associated `PersistentVolumeClaim`, `PersistentVolume` and `volume` in a Workload for any request of a `volume` resource with the `class` `nfs`.

You can find a Score file example using the `volume` resource type [here](https://developer.humanitec.com/examples/score/horizontalpodautoscaler/).
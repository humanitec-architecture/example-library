This section contains Resource Definition examples for handling Kubernetes [Volumes](https://kubernetes.io/docs/concepts/storage/volumes) by using the [`Template`](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/template/) Driver to configure your own volume implementation.

You will find these examples:

- `volume-configmap`: injects a [`configMap` volume](https://kubernetes.io/docs/concepts/storage/volumes/#configmap) into a Workload for any request of a `volume` resource with the `class` `config`
- `volume-dynamic-provisioning`: [dynamic provisioning](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) of a PersistentVolume. Creates the associated `PersistentVolumeClaim` object, and injects the `volume` into a Workload for any request of a `volume` resource with the `class` `standard-rwo`
- `volume-emptydir`: injects an [`emptyDir` volume](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) into a Workload for any request of a `volume` resource with the `class` `ephemeral`
- `volume-nfs`: [static provisioning](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#static) of a PersistentVolume. Creates the associated `PersistentVolumeClaim` and `PersistentVolume` objects, and injects the `volume` into a Workload for any request of a `volume` resource with the `class` `nfs`
- `volume-projected`: injects a [`projected` volume](https://kubernetes.io/docs/concepts/storage/projected-volumes/) into a Workload for any request of a `volume` with the `class` `projected`

You can find a Score file example using the `volume` resource type [here](https://developer.humanitec.com/examples/score/volumes/).

To see examples for the convenience Drivers, see the [`volume-pvc` Driver](https://developer.humanitec.com/examples/resource-definitions/volume-pvc/volumes/) and [`volume-nfs` Driver](https://developer.humanitec.com/examples/resource-definitions/volume-nfs/volumes/) examples.
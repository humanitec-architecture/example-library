# Propagate Class

This example demonstrates how ID propagation through resource references can be used to create a new instance of a resource for another resource. It involves provisioning a `k8s-service-account` resource for every `workload` resource provisioned.

## How the example works

This example is made up of 2 resource definitions. One `workload` and two `k8s-service-account` resource definitions. Both resource definitions use the [`humanitec/template](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/template/) driver.

A resource of type `workload` is automatically provisioned for each workload in an Application in Humanitec. The `workload` will have the _ID_ of `modules.<workload id>` and a class of `default`. This means that if an application contains two workloads called `workload-one` and `workload-two`, two `workload` resources will be provisioned, one with _ID_ `modules.workload-one` and the other with _ID_ `modules.workload-two`.

The `workload-def.yaml` resource definition has a reference to a `k8s-service-account` resource. The resource reference does not specify either the _class_ or the _ID_ of the resource. This means that the `k8s-service-account` resource is provisioned with the same _ID_ and class as the workload.


## Run the example

### Prerequisites

See the [prerequisites section](/README.md#prerequisites) in the README at the root of this repository.

In addition, the environment variable `HUMANITEC_APP` should be set to `example-propagate-class`.

### Cost

This example will result in a single pod and being deployed to a Kubernetes Cluster.

### Deploy the example

1. Create a new app:

   ```bash
   humctl create app "${HUMANITEC_APP}"
   ```

2. Register the resource definitions:

   ```bash
   humctl apply -f ./defs
   ```

3. Deploy the score workload:

   ```bash
   score-humanitec deploy --org "${HUMANITEC_ORG}" --app "${HUMANITEC_APP}" --env "${HUMANITEC_ENV}"
   ```


### Clean up the example

1. Delete the application

   ```bash
   humctl delete app "${HUMANITEC_APP}"
   ```

2. Delete the resource definitions

   ```bash
   humctl delete -f ./defs
   ```
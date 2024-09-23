# Propagate Class

This example demonstrates how [Resource classes](https://developer.humanitec.com/platform-orchestrator/resources/resource-classes/) can be propagate via Resource References. It involves having a single [Resource Definition](https://developer.humanitec.com/platform-orchestrator/resources/resource-definitions/) that can be parameterized by referencing another Resource.

## How the example works

This example is made up of 3 Resource Definitions: one `s3` and two `config` Resource Definitions. To keep the examples as simple as possible, the [`humanitec/echo`](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/echo/) driver is used.

The `s3` Resource Definition [`def-s3.yaml`](./def-s3.yaml) is configured to match to two classes `one` and `two`. It outputs its `bucket` output based on the [Resource Reference](https://developer.humanitec.com/platform-orchestrator/resources/resource-graph/#resource-references) `${resources.config#example.outputs.name}`. This Resource Reference will cause a new resource to be provisioned and be replaced with the `name` output of that newly provisioned resource. As the Resource Definition only defines the _type_ of the resource (`config`) and the _ID_ of the resource (`example`), the _class_ that the new resource will be provisioned with will be the same as the class of the `s3` resource.

The one `config` Resource Definition ([`def-config-one.yaml`](./def-config-one.yaml)) is configured to match the class `one` and the other [`def-config-two.yaml`](./def-config-two.yaml) matches the class `two`.

The [`score.yaml`](./score.yaml) file depends on a resource of type `s3` bucket with a class of `one`. It outputs the bucket name in the environment variable `BUCKET_NAME`.

This means that an S3 bucket will be provisioned via the [`def-s3.yaml`](./def-s3.yaml) Resource Definition and the bucket name will be pulled from the Resource Definition [`def-config-one.yaml`](./def-config-one.yaml) is configured to match the class `one` and so will be `name-01`.

If the class on the `s3` resource is changed to `two` then the bucket name will be pulled from the Resource Definition [`def-config-two.yaml`](./def-config-two.yaml) is configured to match the class `two` and so will be `name-02`.

## Run the demo

### Prerequisites

See the [prerequisites section](/README.md#prerequisites) in the README at the root of this section.

In addition, the environment variable `HUMANITEC_APP` should be set to `example-propagate-class`.

### Cost

This example will result in a single pod being deployed to a Kubernetes Cluster.

### Deploy the example

1. Create a new app:

   ```bash
   humctl create app "${HUMANITEC_APP}"
   ```

2. Register the resource definitions:

   ```bash
   mkdir resource-definitions
   cp def-*.yaml ./resource-definitions
   humctl apply -f ./resource-definitions
   ```

3. Create the Resource Classes

   While not technically required, it is recommended to explicitly [create Resource Classes](https://developer.humanitec.com/platform-orchestrator/resources/resource-classes/#creating-a-resource-class) for types used by developers in Score.

   ```bash
   humctl api post "/orgs/${HUMANITEC_ORG}/resources/types/s3/classes" \
   -d '{
   "id": "one",
   "description": "Sample Resource Class one"
   }'
   ```

   ```bash
   humctl api post "/orgs/${HUMANITEC_ORG}/resources/types/s3/classes" \
   -d '{
   "id": "two",
   "description": "Sample Resource Class two"
   }'
   ```

4. Deploy the Score workload:

   ```bash
   humctl score deploy --org "${HUMANITEC_ORG}" --app "${HUMANITEC_APP}" --env "${HUMANITEC_ENV}" --token "${HUMANITEC_TOKEN}
   ```

### Play with the demo

1. In the Humanitec UI, visit the running deployment and look in the container logs for the line starting with `BUCKET_NAME`. It should have a value of `name-01`

2. Change the class of the `s3` resource in the [`score.yaml`](./score.yaml) file from `one` to `two`.

3. Redeploy the Score file:

   ```bash
   humctl score deploy --org "${HUMANITEC_ORG}" --app "${HUMANITEC_APP}" --env "${HUMANITEC_ENV}"--token "${HUMANITEC_TOKEN}
   ```

4. In the Humanitec UI, visit the running deployment and look in the container logs for the line starting with `BUCKET_NAME`. It should now have a value of `name-02`

### Clean up the example

1. Delete the Application:

   ```bash
   humctl delete app "${HUMANITEC_APP}"
   ```

2. Delete the Resource Definitions:

   ```bash
   humctl delete -f ./resource-definitions
   rm -rf ./resource-definitions
   ```

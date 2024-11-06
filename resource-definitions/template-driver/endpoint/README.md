This section contains example Resource Definitions using the [Template Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/template/) for creating a `endpoint` resource.

The `endpoint` resource is used to represent an endpoint that a workload needs to interact with. This could for example be a shared service, external API etc.

Here, the template driver is used to provide optional outputs making use of the [`default`](https://masterminds.github.io/sprig/defaults.html#default) function as well as [`merge`](https://masterminds.github.io/sprig/dicts.html#merge-mustmerge) to construct [dictionaries](https://masterminds.github.io/sprig/dicts.html#dict) with default values.
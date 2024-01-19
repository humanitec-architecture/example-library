# Resource Graph Patterns

This repo contains a set of examples of patterns that can be used when building [Resource Graphs](https://developer.humanitec.com/platform-orchestrator/resources/resource-graph/). Each pattern is explained along with use cases for when the pattern can be useful.

## Example Patterns

- [Propagate Class](./propagate-class/README.md): Having a single resource definition that can be parameterized by referencing another resource.

## Running the examples

### Prerequisites

In order to try out these examples, the following is necessary:

- A Humanitec Organization.
- The [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/)
- The [score-humanitec CLI](https://github.com/score-spec/score-humanitec/releases/latest)
- An [API Token for a Service User](https://developer.humanitec.com/platform-orchestrator/security/service-users) with the Administrator role on the Humanitec Organization.
- A `k8s-cluster` Resource Definition that matches to the `development` environment of the `application` defined in each example.

The environment must be configured with the following environment variables:

| Variable | Description |
| --- | --- |
| `HUMANITEC_ORG` | The ID of the Humanitec Organization. |
| `HUMANITEC_TOKEN` | The API Token for the service user with Administrator role on the Humanitec Organization |
| `HUMANITEC_DEV` | This should be set to `development` | 

**NOTE:**

It is usually necessary to export the environment variable into the shell's environment if you wish to use the CLIs interactively.

For example:
```bash
export HUMANITEC_ORG="my-org"
```
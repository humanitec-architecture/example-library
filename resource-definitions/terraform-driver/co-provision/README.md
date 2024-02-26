## Resource co-provisioning

This section contains an example of Resource Definitions using the [Terraform Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform/) and illustrating the [co-provisioning](https://developer.humanitec.com/platform-orchestrator/resources/resource-graph/#co-provision-resources) concept.

Scenario: For each AWS S3 bucket resource an AWS IAM policy resource must be created. The bucket properties (region, ARN) should be passed to the policy resource. 
In other words, an IAM Policy resource depends on a S3 resource, but it needs to be created automatically.

```mermaid
flowchart TB
  subgraph fig1 ["<b>S3</b> co-provisions <b>AWS Policy</b>, <b>AWS Policy</b> has a reference to <b>S3</b>"]
    direction LR
    R1(R) --->|references| R2(S3)
    N1(AWS Policy) --->|references| R2
  end
  classDef pClass fill:#fff,stroke:#000,stroke-width:1px
  classDef rClass fill:#fff,stroke:#000,stroke-width:2px
  classDef nClass fill:#fff,stroke:#000,stroke-width:2px,stroke-dasharray: 5 5
  class R1 pClass
  class R2 rClass
  class N1 nClass
  classDef subgraphClass fill:#fff,stroke-width:0,white-space:nowrap
  class fig1 subgraphClass
```

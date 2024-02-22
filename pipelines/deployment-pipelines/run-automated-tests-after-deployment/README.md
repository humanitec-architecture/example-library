When the Platform Orchestrator deploys changes into an Environment, the Deployment status indicates whether it successfully provisioned associated resources and configured the Workloads. It does not necessarily imply that the Applications are healthy or that the desired functionality is available to end users. This is why a major benefit of Continuous Delivery Pipelines is the ability to perform health checks and run a suite of tests against the running application in a pre-production or even production Environment.

Humanitec Pipelines can be used to achieve this goal by combining the common deployment steps with steps that wait for readiness, and execute external tests in systems such as GitHub Actions or GitLab Pipelines.

The [example Pipeline](pipeline.yaml) uses a GitHub Action.

Once configured for the target environment using deployment request Matching Criteria, this Pipeline will now fail automatically when any of the following happens:

1. The deployment fails, due to reasons like invalid configuration, inaccessible Kubernetes clusters, or failures to provision resources in the Platform Orchestrator
1. Workloads that fail to reach a ready state
1. Failures occur in the attached GitHub Actions Workflow

All of these events are valuable health tests that can be automated by Humanitec Pipelines.
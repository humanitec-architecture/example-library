Humanitec Pipelines supports an `http` action which is able to send external requests with data from the Pipeline execution. This can be used to trigger or notify external systems. One example of this is to notify a channel in Slack or raise a support request or ticket.

In the following example, we’ll notify a Slack channel of the success or failure of all deployments through the Pipeline.

The Slack credential is stored as a secret [Application Shared Value](https://developer.humanitec.com/platform-orchestrator/working-with/shared-values).
In the "[promote between environments](../promote-between-environments-after-a-manual-approval/)" example, a Pipeline is used to promote a Workload from development to production. To ensure that all changes to production have first been tested in development, it may be necessary to block direct deployment of Deltas to production. Deployment request Matching Criteria can be used for this.

First, create a [Pipeline](pipeline.yaml) that always fails with a log message.

Then link this Pipeline to the production Environment with the following [Matching Criteria](https://developer.humanitec.com/integration-and-extensions/humanitec-pipelines/deployment-pipelines/#pipeline-matching-criteria):

- `app_id`: `my-application`
- `env_id`: `production`
- `deployment_type`: `deploy`

The `deployment_type`: `deploy` part effectively excludes the `re-deploy` situation because you still want to be able to rollback production to a previous release without re-promoting a change through the promotion pipeline. This can be relevant e.g. during an incident or other operational needs.

Because this Pipeline is triggered by `deployment_request`, any direct deployments through the user interface and APIs will run through this Pipeline and fail before the deployment takes place.

Deployments through other Pipelines, such as the aforementioned promotion Pipeline, will still continue as normal.

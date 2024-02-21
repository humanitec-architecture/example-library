In the "[promote between environments](../promote-between-environments-after-a-manual-approval/)" example, a Pipeline is used to promote a Workload from development to production. To ensure that all changes to production have first been tested in development, it may be necessary to block direct deployment of Deltas to production. Deployment request matching criteria can be used for this.

First, create a [Pipeline](pipeline.yaml) that always fails with a log message.

Then link this Pipeline to the production environment with the following matching criteria:

- `app_id`: `my-application`
- `env_id`: `production`

Because this Pipeline is triggered by `deployment_request`, any direct deployments through the user interface and APIs will run through this Pipeline and fail before the deployment takes place.

Deployments through other Pipelines, such as the aforementioned promotion pipeline, will still continue as normal.
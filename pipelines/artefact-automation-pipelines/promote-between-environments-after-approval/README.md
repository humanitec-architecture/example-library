While automated Continuous Delivery of deployments to a production Environment may be a goal, you may come across scenarios in which a manual approval must be given by a user or external system before promoting a sensitive component or change into an Environment.

In the following [example](pipeline.yaml), Humanitec Pipelines will be used to request a manual approval before cloning a Workload artefact to a production Environment. 

The Pipeline consists of three jobs, `deploy-to-dev`, `wait-for-approval`, and `deploy-to-production`. The dependencies between the jobs are indicated by the `needs` property. `deploy-to-dev` and `deploy-to-production` have the same logic, but target different Environments, while the `wait-for-approval` job will block the Pipeline until a user with the `deployer` role on the `production` Environment approves or denies the approval request which can be retrieved through the user interface or [API](https://api-docs.humanitec.com/#tag/PipelineApprovals).

Note that this Pipeline uses artefact automation and is triggered by uploading a new version of the `myProject/myWorkloadArtefact` Score artefact.

The Pipeline also makes use of a [concurrency group](https://developer.humanitec.com/integration-and-extensions/humanitec-pipelines/specification/#concurrency) ensuring that subsequent runs are queued and deployment sequences from development to production do not overlap.
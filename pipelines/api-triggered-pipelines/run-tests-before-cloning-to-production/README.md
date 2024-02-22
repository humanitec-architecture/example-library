In some environments, continuously deploying all changes from development to production may not be desirable. It may be more important to promote on a manually (or externally) triggered schedule.

The following [Pipeline](pipeline.yaml) can be triggered over the API and will execute tests using GitHub Actions before cloning and deploying.

This Pipeline can now be executed through API requests or by clicking the Run button in the Humanitec Platform Orchestrator UI.
# GitLab HTTP Backend using Long Lived credentials

[GitLab implements](https://docs.gitlab.com/ee/user/infrastructure/iac/terraform_state.html#set-up-the-initial-backend) the [Terraform HTTP backend](https://developer.hashicorp.com/terraform/language/v1.5.x/settings/backends/http). In order to use the Terraform backend in GitLab, the following is needed:

- A Personal Access Token with `api` scope
- A GitLab project that the token has access to.

This example has a simple resource definition using the Terraform Driver. The backend configuration is generated via a `config` resource and then injected as a file in the terraform resource definition using a placeholder.

The following needs to be defined in the config for this example to work:
- `.entity.driver_inputs.values.gitlab_project_id` - Should be the numerical ID of the GitLab project being used to store the state
- `.entity.driver_inputs.secret_refs.username` - The username that the Personal Access token is associated with
- `.entity.driver_inputs.secret_refs.password` - The value of the Personal Access token

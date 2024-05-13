## Custom git-config for sourcing Terraform modules

This section contains an example of providing a custom git-config to be used by Terraform when accessing modules sources from private git repositories. 

Terraform can use [modules from various sources including git](https://developer.hashicorp.com/terraform/language/v1.5.x/modules/sources). The documentation [states](https://developer.hashicorp.com/terraform/language/v1.5.x/modules/sources#generic-git-repository): _Terraform installs modules from Git repositories by running git clone, and so it will respect any local Git configuration set on your system, including credentials. To access a non-public Git repository, configure Git with suitable credentials for that repository._

Custom git configuration can be provided by including a file with name `.gitconfig` in the `files` input. This file can be either a value or a secret depending on whether it contains sensitive credentials or not.

In this example we add a `git-config` that re-writes URLs.
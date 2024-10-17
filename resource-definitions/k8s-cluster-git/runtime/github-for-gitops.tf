resource "humanitec_resource_definition" "github-for-gitops" {
  driver_type = "humanitec/k8s-cluster-git"
  id          = "github-for-gitops"
  name        = "github-for-gitops"
  type        = "k8s-cluster"
  driver_inputs = {
    values_string = jsonencode({
      "url"          = "git@github.com:example-org/gitops-repo.git"
      "branch"       = "development"
      "path"         = "$${context.app.id}/$${context.env.id}"
      "loadbalancer" = "35.10.10.10"
    })
    secrets_string = jsonencode({
      "credentials" = {
        "ssh_key" = "my-git-ssh-key"
      }
    })
  }

  # To co-provision another k8s-cluster resource the Orchestrator will fetch runtime info from
  provision = {
    "k8s-cluster#k8s-cluster-runtime" : {
      is_dependent     = false
      match_dependents = false
    }
  }
}


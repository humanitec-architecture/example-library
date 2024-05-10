# EKS private cluster. It is to be accessed via the Humanitec Agent
# It is using a Cloud Account with dynamic credentials
resource "humanitec_resource_definition" "eks-agent" {
  id          = "eks-agent"
  name        = "eks-agent"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster-eks"
  # The driver_account is referring to a Cloud Account resource
  driver_account = humanitec_resource_account.aws-dynamic.id

  driver_inputs = {
    values_string = jsonencode({
      "name"   = var.eks_cluster_name
      "region" = var.aws_region
    })
    # Setting the URL for the Humanitec Agent
    secrets_string = jsonencode({
      "agent_url" = "$${resources['agent#agent'].outputs.url}"
    })
  }
}

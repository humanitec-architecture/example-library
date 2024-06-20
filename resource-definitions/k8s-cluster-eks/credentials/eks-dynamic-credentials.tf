# Connect to an EKS cluster using dynamic credentials defined via a Cloud Account
resource "humanitec_resource_definition" "eks-dynamic-credentials" {
  id          = "eks-dynamic-credentials"
  name        = "eks-dynamic-credentials"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster-eks"
  # The driver_account is referring to a Cloud Account resource
  driver_account = humanitec_resource_account.aws-dynamic.id

  driver_inputs = {
    values_string = jsonencode({
      "name"                     = var.eks_cluster_name
      "region"                   = var.aws_region
      "loadbalancer"             = var.eks_loadbalancer
      "loadbalancer_hosted_zone" = var.eks_loadbalancer_hostedzone
    })
  }
}

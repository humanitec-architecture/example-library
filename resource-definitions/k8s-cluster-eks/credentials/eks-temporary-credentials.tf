# Connect to an EKS cluster using temporary credentials defined via a Cloud Account
resource "humanitec_resource_definition" "eks-temporary-credentials" {
  id          = "eks-temporary-credentials"
  name        = "eks-temporary-credentials"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster-eks"
  # The driver_account is referring to a Cloud Account resource
  driver_account = humanitec_resource_account.aws-temporary.id

  driver_inputs = {
    values_string = jsonencode({
      "name"                     = var.eks_cluster_name
      "region"                   = var.aws_region
      "loadbalancer"             = var.eks_loadbalancer
      "loadbalancer_hosted_zone" = var.eks_loadbalancer_hostedzone
    })
  }
}

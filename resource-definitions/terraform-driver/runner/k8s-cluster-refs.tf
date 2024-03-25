resource "humanitec_resource_definition" "eks_resource_cluster" {
  id          = "eks-enabled-cluster"
  name        = "eks-enabled-cluster"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster-eks"

  driver_inputs = {
    secrets = {
      credentials = {
        aws_access_key_id     = var.aws_access_key_id
        aws_secret_access_key = var.aws_secret_access_key
      }
    }

    values = {
      loadbalancer             = "10.10.10.10"
      name                     = "my-cluster"
      region                   = "eu-central-1"
      loadbalancer             = "x111111xxx111111111x1xx1x111111x-x111x1x11xx111x1.elb.eu-central-1.amazonaws.com"
      loadbalancer_hosted_zone = "ABC0DEF5WYYZ00"
    }
  }
}


resource "humanitec_resource_definition_criteria" "eks_resource_cluster" {
  resource_definition_id = humanitec_resource_definition.eks_resource_cluster.id
  class                  = "runner"
}

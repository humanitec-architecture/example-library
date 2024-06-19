## Using the Amazon Load Balancer

This section contains example Resource Definitions using the [Amazon Application Load Balancer (ALB)](https://aws.amazon.com/elasticloadbalancing/application-load-balancer/) for handling Kubernetes ingress traffic.

* [ingress-alb.tf](ingress-alb.tf): defines an `Ingress` annotated for an internet-facing ALB. This format is for use with the [Humanitec Terraform Provider](https://registry.terraform.io/providers/humanitec/humanitec)
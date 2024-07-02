# This Resource Definition provisions an Ingress object for the Amazon Application Load Balancer (ALB)

variable "ingress_resource_name" {}
variable "ingress_group_name" {}
variable "ingress_cert_arn" {}

resource "humanitec_resource_definition" "ingress" {
  id          = var.ingress_resource_name
  name        = var.ingress_resource_name
  type        = "ingress"
  driver_type = "humanitec/ingress"

  driver_inputs = {
    values_string = jsonencode({
      "annotations" : jsonencode({
        "alb.ingress.kubernetes.io/certificate-arn" : "${var.ingress_cert_arn}",
        "alb.ingress.kubernetes.io/group.name" : "${var.ingress_group_name}",
        "alb.ingress.kubernetes.io/listen-ports" : "[{\"HTTP\":80},{\"HTTPS\":443}]",
        "alb.ingress.kubernetes.io/scheme" : "internet-facing",
        "alb.ingress.kubernetes.io/ssl-redirect" : "443",
        "alb.ingress.kubernetes.io/target-type" : "ip"
      }),
      "class" : "alb",
      "no_tls" : true
    })
  }
}
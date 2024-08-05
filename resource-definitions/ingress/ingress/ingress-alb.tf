resource "humanitec_resource_definition" "alb-ingress" {
  driver_type = "humanitec/ingress"
  id          = "alb-ingress"
  name        = "alb-ingress"
  type        = "ingress"
  driver_inputs = {
    values_string = jsonencode({
      "annotations" = {
        "alb.ingress.kubernetes.io/certificate-arn" = "arn:aws:acm:us-west-2:xxxxx:certificate/xxxxxxx"
        "alb.ingress.kubernetes.io/group.name"      = "my-team.my-group"
        "alb.ingress.kubernetes.io/listen-ports"    = "[{\"HTTP\":80},{\"HTTPS\":443}]"
        "alb.ingress.kubernetes.io/scheme"          = "internet-facing"
        "alb.ingress.kubernetes.io/ssl-redirect"    = "443"
        "alb.ingress.kubernetes.io/target-type"     = "ip"
      }
      "class"  = "alb"
      "no_tls" = true
    })
  }
}


resource "humanitec_resource_definition" "container-driver-secrets-example-mysql-instance" {
  driver_type = "humanitec/echo"
  id          = "container-driver-secrets-example-mysql-instance"
  name        = "container-driver-secrets-example-mysql-instance"
  type        = "mysql-instance"
  driver_inputs = {
    values_string = jsonencode({
      "name" = "my-instance"
      "host" = "products.mysql.dev.example.com"
      "port" = 5432
    })
    secret_refs = jsonencode({
      "username" = {
        "store" = "my-secret-store"
        "ref"   = "my-instance-username"
      }
      "password" = {
        "store" = "my-secret-store"
        "ref"   = "my-instance-password"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "container-driver-secrets-example-mysql-instance_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.container-driver-secrets-example-mysql-instance.id
  app_id                 = "container-driver-secrets-example"
}

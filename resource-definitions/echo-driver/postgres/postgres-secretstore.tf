resource "humanitec_resource_definition" "postgres-echo" {
  driver_type = "humanitec/echo"
  id             = "postgres-echo"
  name           = "postgres-echo"
  type           = "postgres"
  driver_inputs  = {
    values_string  = jsonencode({
      "name" = "my-database"
      "host" = "products.postgres.dev.example.com"
      "port" = 5432
    })
    secret_refs    = jsonencode({
      "username" = {
        "store" = "my-gsm"
        "ref" = "cloudsql-username"
      }
      "password" = {
        "store" = "my-gsm"
        "ref" = "cloudsql-password"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "postgres-echo_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.postgres-echo.id 

}

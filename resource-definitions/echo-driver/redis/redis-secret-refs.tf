resource "humanitec_resource_definition" "redis-echo" {
  driver_type = "humanitec/echo"
  id             = "redis-echo"
  name           = "redis-echo"
  type           = "redis"
  driver_inputs  = {
    values_string  = jsonencode({
      "host" = "0.0.0.0"
      "port" = 6379
    })
    secret_refs    = jsonencode({
      "password" = {
        "store" = "my-gsm"
        "ref" = "redis-password"
      }
      "username" = {
        "store" = "my-gsm"
        "ref" = "redis-user"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "redis-echo_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.redis-echo.id 

}

resource "humanitec_resource_definition" "example-git-config" {
  driver_type = "humanitec/terraform"
  id             = "example-git-config"
  name           = "example-git-config"
  type           = "s3"
  driver_inputs  = {
    values_string  = jsonencode({
      "files" = {
        ".gitconfig" = <<END_OF_TEXT
[url "https://github.com/Invicton-Labs/"]
    insteadOf = https://example.com/replace-with-git-config/
END_OF_TEXT
      }
      "script" = <<END_OF_TEXT
module "uuid" {
  # We rely on the git-config above to rewrite this URL into one that will work
  source = "git::https://example.com/replace-with-git-config/terraform-random-uuid.git?ref=v0.2.0"
}

output "bucket" {
  value = module.uuid.uuid
}
END_OF_TEXT
    })
  }
}



resource "humanitec_resource_definition" "aws_terraform_resource_s3_bucket" {
  id          = "aws-terrafom-s3-bucket"
  name        = "aws-terrafom-s3-bucket"
  type        = "s3"
  driver_type = "humanitec/terraform"

  driver_inputs = {

    secrets = {
      variables = jsonencode({
        access_key = var.access_key
        secret_key = var.secret_key

      })
      source = jsonencode({
        # Provide either an SSH key (for SSH connection) or password (for HTTPS).
        ssh_key  = var.ssh_key
        password = var.password
      })
    }
    
    values = {
      # Connection information to the Git repo containing the Terraform code
      "source" = jsonencode(
        {
          path = "s3/terraform/bucket/"
          rev  = "refs/heads/main"
          url  = "https://my-domain.com/my-org/my-repo.git"
        }
      )
      "variables" = jsonencode(
        {
          # Provide a separate bucket per Application and Environment
          bucket          = "my-company-my-app-$${context.app.id}-$${context.env.id}"
          region          = var.region
          assume_role_arn = var.assume_role_arn
        }
      )
    }
  }
}

resource "humanitec_resource_definition" "blob-storage-dynamic-credentials" {
  driver_type    = "humanitec/terraform"
  id             = "blob-storage-dynamic-credentials"
  name           = "blob-storage-dynamic-credentials"
  type           = "azure-blob"
  driver_account = "azure-dynamic-creds"
  driver_inputs = {
    values_string = jsonencode({
      "variables" = {
        "location"            = "eastus"
        "resource_group_name" = "my-test-resources"
        "tenant_id"           = "3987ae5f-008f-4265-a6ee-e9dcedce4742"
        "subscription_id"     = "742f6d8b-1b7b-4c6a-9f37-90bdd5aeb996"
        "client_id"           = "c977c44d-3003-464c-b163-03920d4a390b"
      }
      "credentials_config" = {
        "variables" = {
          "oidc_token" = "oidc_token"
        }
      }
      "script" = "# This provider block is using the Terraform variables\n# set through the credentials_config.\n# Variable declarations omitted for brevity.\nprovider \"azurerm\" {\n  features {}        \n  subscription_id = var.subscription_id\n  tenant_id       = var.tenant_id\n  client_id       = var.client_id\n  use_oidc        = true\n  oidc_token      = var.oidc_token\n}\n\n# ... Terraform code reduced for brevity\n\nresource \"azurerm_storage_account\" \"example\" {\n  name                     = \"mystorageaccount\"\n  resource_group_name      = var.resource_group_name\n  location                 = var.location\n  account_tier             = \"Standard\"\n  account_replication_type = \"LRS\"\n}\n\nresource \"azurerm_storage_container\" \"example\" {\n  name                  = \"mystorage\"\n  storage_account_name  = azurerm_storage_account.example.name\n  container_access_type = \"private\"\n}"
    })
  }
}


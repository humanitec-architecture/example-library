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
      "script" = <<END_OF_TEXT
# This provider block is using the Terraform variables
# set through the credentials_config.
# Variable declarations omitted for brevity.
provider "azurerm" {
  features {}        
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  use_oidc        = true
  oidc_token      = var.oidc_token
}

# ... Terraform code reduced for brevity

resource "azurerm_storage_account" "example" {
  name                     = "mystorageaccount"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "mystorage"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}
END_OF_TEXT
    })
  }
}


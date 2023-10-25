##Resource Group
resource "azurerm_resource_group" "main_rg" {
  name     = var.resource_group
  location = var.azure_region[0]
}
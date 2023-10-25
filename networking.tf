## VNETs for deployment
resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet_conf
  name                = each.value.name
  location            = each.value.region
  resource_group_name = azurerm_resource_group.main_rg.name
  address_space       = [each.value.cidr]
}

## Subnets for deployment
resource "azurerm_subnet" "main_sub" {
  for_each             = var.vnet_conf
  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = each.value.name
  address_prefixes     = [each.value.subnet]

  ## Waiting for the VNETs to provision before deploying subnets
  depends_on = [azurerm_virtual_network.vnet]
}
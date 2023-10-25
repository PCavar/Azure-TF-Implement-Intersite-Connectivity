## Peering Vnet0 with Vnet1
resource "azurerm_virtual_network_peering" "local_peering_0_to_1" {
  name                      = var.local_peering_name[0]
  resource_group_name       = azurerm_resource_group.main_rg.name
  virtual_network_name      = var.vnet_conf["vnet0"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["vnet1"].id
}

## Peering Vnet1 with Vnet0
resource "azurerm_virtual_network_peering" "local_peering_1_to_0" {
  name                      = var.local_peering_name[1]
  resource_group_name       = azurerm_resource_group.main_rg.name
  virtual_network_name      = var.vnet_conf["vnet1"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["vnet0"].id
}

## Peering Vnet0 with Vnet2 (Global-Peering)
resource "azurerm_virtual_network_peering" "global_peering_0_to_2" {
  name                      = var.global_peering_name[0]
  resource_group_name       = azurerm_resource_group.main_rg.name
  virtual_network_name      = var.vnet_conf["vnet0"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["vnet2"].id

  ## allow_gateway_transit must be set to false for global peering
  allow_virtual_network_access = true
  allow_gateway_transit        = false
}

## Peering Vnet2 with Vnet0 (Global-Peering)
resource "azurerm_virtual_network_peering" "global_peering_2_to_0" {
  name                      = var.global_peering_name[1]
  resource_group_name       = azurerm_resource_group.main_rg.name
  virtual_network_name      = var.vnet_conf["vnet2"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["vnet0"].id

  ## allow_gateway_transit must be set to false for global peering
  allow_virtual_network_access = true
  allow_gateway_transit        = false
}

## Peering Vnet1 with Vnet2 (Global-Peering)
resource "azurerm_virtual_network_peering" "global_peering_1_to_2" {
  name                      = var.global_peering_name[2]
  resource_group_name       = azurerm_resource_group.main_rg.name
  virtual_network_name      = var.vnet_conf["vnet1"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["vnet2"].id

  ## allow_gateway_transit must be set to false for global peering
  allow_virtual_network_access = true
  allow_gateway_transit        = false
}

## Peering Vnet2 with Vnet1 (Global-Peering)
resource "azurerm_virtual_network_peering" "global_peering_2_to_1" {
  name                      = var.global_peering_name[3]
  resource_group_name       = azurerm_resource_group.main_rg.name
  virtual_network_name      = var.vnet_conf["vnet2"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["vnet1"].id

  ## allow_gateway_transit must be set to false for global peering
  allow_virtual_network_access = true
  allow_gateway_transit        = false
}
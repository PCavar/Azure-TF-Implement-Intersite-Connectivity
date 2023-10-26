## Creating Public IP Addresses
resource "azurerm_public_ip" "main_pup" {
  for_each            = var.vm_conf
  name                = each.value.pub_name
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = each.value.region
  allocation_method   = "Dynamic"
}

## Creating NICs and attaching private/public IPs
resource "azurerm_network_interface" "nic_main" {
  for_each            = var.vm_conf
  name                = each.value.nic_name
  location            = each.value.region
  resource_group_name = azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = each.value.nic_name
    subnet_id                     = azurerm_subnet.main_sub[each.value.subnet_key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main_pup[each.key].id
  }
}

## Provisioning Virtual Machines
resource "azurerm_windows_virtual_machine" "vms" {
  for_each            = var.vm_conf
  name                = each.value.vm_name
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = each.value.region
  size                = each.value.size
  admin_username      = each.value.admin_name
  admin_password      = each.value.admin_pass

  network_interface_ids = [
    azurerm_network_interface.nic_main[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.src_img_ref["source_vm"].publisher
    offer     = var.src_img_ref["source_vm"].offer
    sku       = var.src_img_ref["source_vm"].sku
    version   = var.src_img_ref["source_vm"].version
  }
}
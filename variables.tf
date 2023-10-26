variable "azure_region" {
  type        = list(string)
  description = "Regions to Deploy to"
  default     = ["North Europe", "West Europe"]
}

variable "resource_group" {
  type        = string
  description = "Resource group name"
  default     = "az104-05-rg1"
}

variable "local_peering_name" {
  type        = list(string)
  description = "Names of the local peerings"
  default = [
    "Peered-Vnet0-Vnet1-Local",
    "Peered-Vnet1-Vnet0-Local",
  ]
}

variable "global_peering_name" {
  type        = list(string)
  description = "Names of the global peerings"
  default = [
    "Peered-Vnet0-to-Vnet2-Global",
    "Peered-Vnet2-to-Vnet0-Global",
    "Peered-Vnet1-to-Vnet2-Global",
    "Peered-Vnet2-to-Vnet1-Global"
  ]
}

variable "src_img_ref" {
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
  default = {
    source_vm = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }
  }
}

variable "vnet_conf" {
  type = map(object({
    name        = string
    cidr        = string
    subnet      = string
    region      = string
    subnet_name = string
    peer_1      = string
    peer_2      = string
  }))
  default = {
    vnet0 = {
      name        = "az104-05-vnet0"
      cidr        = "10.50.0.0/22"
      subnet      = "10.50.0.0/24"
      region      = "North Europe"
      subnet_name = "Subnet0"
      peer_1      = "peering1-2"
      peer_2      = "peering2-1"
    },
    vnet1 = {
      name        = "az104-05-vnet1"
      cidr        = "10.51.0.0/22"
      subnet      = "10.51.0.0/24"
      region      = "North Europe"
      subnet_name = "Subnet1"
      peer_1      = "peering1-2"
      peer_2      = "peering2-1"
    },
    vnet2 = {
      name        = "az104-05-vnet2"
      cidr        = "10.52.0.0/22"
      subnet      = "10.52.0.0/24"
      region      = "West Europe"
      subnet_name = "Subnet2"
      peer_1      = "peering1-2"
      peer_2      = "peering2-1"
    }
  }
}

variable "vm_conf" {
  description = "Virtual Machines Configuration"
  type = map(object({
    vm_name    = string
    pip_name   = string
    pub_name   = string
    nic_name   = string
    region     = string
    subnet_key = string
    size       = string
    admin_name = string
    admin_pass = string
  }))
  default = {
    vm0 = {
      vm_name    = "az104-05-vm0"
      pip_name   = "az104-05-pip0"
      nic_name   = "az104-05-nic0"
      region     = "North Europe"
      subnet_key = "vnet0"
      pub_name   = "az104-05-pub0"
      size       = "Standard_D2_v2"
      admin_name = "azurestudent"       ##NOT BEST PRACTICE OR RECOMMENDED STORING SENSITIVE INFORMATION LIKE THIS
      admin_pass = "azurestudent12345!" ## Only for quick deployment purposes
    },
    vm1 = {
      vm_name    = "az104-05-vm1"
      pip_name   = "az104-05-pip1"
      nic_name   = "az104-05-nic1"
      region     = "North Europe"
      subnet_key = "vnet1"
      pub_name   = "az104-05-pub1"
      size       = "Standard_D2_v2"
      admin_name = "azurestudent"       ##NOT BEST PRACTICE OR RECOMMENDED STORING SENSITIVE INFORMATION LIKE THIS
      admin_pass = "azurestudent12345!" ## Only for quick deployment purposes
    },
    vm2 = {
      vm_name    = "az104-05-vm2"
      pip_name   = "az104-05-pip2"
      nic_name   = "az104-05-nic2"
      region     = "West Europe"
      subnet_key = "vnet2"
      pub_name   = "az104-05-pub2"
      size       = "Standard_D2_v2"
      admin_name = "azurestudent"       ##NOT BEST PRACTICE OR RECOMMENDED STORING SENSITIVE INFORMATION LIKE THIS
      admin_pass = "azurestudent12345!" ## Only for quick deployment purposes
    }
  }
}
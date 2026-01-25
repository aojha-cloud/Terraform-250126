module "vnet_root_module" {
  source                  = "./VirtualNetwork"
  for_each                = var.vnets
  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  address_space           = each.value.address_space
  dns_servers             = each.value.dns_servers
  tags                    = each.value.tags
  flow_timeout_in_minutes = each.value.flow_timeout_in_minutes
  ddos_protection_plan    = each.value.ddos_protection_plan
  encryption              = each.value.encryption
  ip_address_pool         = each.value.ip_address_pool
  subnet                  = each.value.subnet
}

variable "vnets" {
  type    = any
  default = {}
}

terraform {
  required_version = "1.9.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.58.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "<SUBSCRIPTION_ID>"
}

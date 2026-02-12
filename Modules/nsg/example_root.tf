module "nsg" {
  source = ".child_module_nsg"
  for_each = var.nsgs
  name = lookup(each.value, "nsg_name", null)
  location = lookup(each.value, "location", null) # each.value.location
  resource_group_name = lookup(each.value, "nsg_resourceGroup", null) # each.value.nsg_resourceGroup
  security_rule = lookup(each.value, "security_rules", []   ) # each.value.security_rules
  tags = lookup(each.value, "tags", {}) # each.value.tags
}

terraform {
  required_version = ">=1.9.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.35.0"
    }
  }
}
provider "azurerm" {
    features {
      
    }
  
}
variable "nsgs" {

  description = "Map of NSG configurations"
  type = any
  default = {}
  
}
resource "azurerm_network_security_group" "child_module_nsg" {
    name                = var.nsg_name
    location            = var.location
    resource_group_name = var.resource_group_name
    tags =  var.tags

    dynamic "security_rule" {
      for_each = var.security_rule != null ? var.security_rule : []
      content {
        name                       = security_rule.value.name
        description                = security_rule.value.description
        protocol                   = security_rule.value.protocol
        priority                   = security_rule.value.priority
        direction                  = security_rule.value.direction
        access                     = security_rule.value.access
        source_port_range          = security_rule.value.source_port_range
        source_port_ranges = security_rule.value.source_port_ranges
        destination_port_range     = security_rule.value.destination_port_range
        destination_port_ranges = security_rule.value.destination_port_ranges
        source_address_prefix    = security_rule.value.source_address_prefixes
        source_address_prefixes = security_rule.value.source_address_prefixes
        destination_address_prefix    = security_rule.value.destination_address_prefix
        destination_address_prefixes = security_rule.value.destination_address_prefixes
        destination_application_security_group_ids = security_rule.value.destination_application_security_group_ids
        source_application_security_group_ids = security_rule.value.source_application_security_group_ids
        
      }
    }
  
}
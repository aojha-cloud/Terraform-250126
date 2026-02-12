output "id" {
    description = "NSG Resource ID"
    value = azurerm_network_security_group.child_module_nsg.id
}
output "name" {
  description = "NSG Name"
    value = azurerm_network_security_group.child_module_nsg.name
}
output "separate_rule_ids" {
  description = "IDs of separate security rules."
  value = { for k, r in azurerm_network_security_group.child_module_nsg : k => r.id }
}


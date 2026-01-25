output "id" {
  value = azurerm_virtual_network.child_vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.child_vnet.name
}

output "address_space" {
  value = azurerm_virtual_network.child_vnet.address_space
}

output "subnet_ids" {
  value = [azurerm_virtual_network.child_vnet.subnet[*].id]
}

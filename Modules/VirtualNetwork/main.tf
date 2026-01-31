resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = "${var.vnet_name}-ddos"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags
}
resource "azurerm_virtual_network" "vnet" {
  name                           = var.vnet_name
  location                       = data.azurerm_resource_group.rg.location
  resource_group_name            = data.azurerm_resource_group.rg.name
  address_space                  = var.address_space
  dns_servers                    = var.dns_servers
  bgp_community                  = var.bgp_community
  edge_zone                      = var.edge_zone
  flow_timeout_in_minutes        = var.flow_timeout_in_minutes
  private_endpoint_vnet_policies = var.private_endpoint_vnet_policies
  tags                           = var.tags

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.ddos.id
    enable = var.enable_ddos_protection
  }
  subnet {
    name             = var.sbnet1name
    address_prefixes = var.address_prefixes
  }

}




resource "azurerm_virtual_network" "child_vnet" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  address_space           = var.address_space
  dns_servers             = var.dns_servers
  tags                    = var.tags
  flow_timeout_in_minutes = var.flow_timeout_in_minutes

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan != null ? var.ddos_protection_plan : {}
    content {
      id     = ddos_protection_plan.id
      enable = ddos_protection_plan.enable
    }
  }

  dynamic "encryption" {
    for_each = var.encryption != null ? var.encryption : {}
    content {
      enforcement = encryption.enforcement
    }

  }

  dynamic "ip_address_pool" {
    for_each = var.ip_address_pool != null ? var.ip_address_pool : []
    content {
      id                     = ip_address_pool.id
      number_of_ip_addresses = ip_address_pool.number_of_ip_addresses
    }
  }

  dynamic "subnet" {
    for_each = var.subnet != null ? var.subnet : []
    content {
      name                              = subnet.value.name
      address_prefixes                  = subnet.value.address_prefixes
      security_group                    = subnet.value.security_group
      route_table_id                    = subet.value.route_table_id
      default_outbound_access_enabled   = subnet.value.default_outbound_access_enabled
      private_endpoint_network_policies = subnet.value.private_endpoint_network_policies
      service_endpoints                 = subnet.value.service_endpoints
      service_endpoint_policy_ids       = subnet.value.service_endpoint_policy_ids
      dynamic "delegation" {
        for_each = subnet.value.delegations != null ? subnet.value.delegations : []
        content {
          name = delegation.value.name
          service_delegation {
            name    = delegation.value.service_delegation.name
            actions = delegation.value.service_delegation.actions
          }
        }
      }
    }
  }
}



variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "address_space" {
  type    = list(string)
  default = []
}


variable "dns_servers" {
  type    = list(string)
  default = []
}


variable "flow_timeout_in_minutes" {
  type    = number
  default = 4

  validation {
    condition     = var.flow_timeout_in_minutes >= 4 && var.flow_timeout_in_minutes <= 30
    error_message = "flow_timeout_in_minutes must be between 4 and 30 minutes."
  }

}

variable "tags" {
  type    = map(string)
  default = {}

}


variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}


variable "encryption" {
  type = object({
    enforcement = string
  })
  default = null
}


variable "ip_address_pool" {
  type = list(object({
    id                     = string
    number_of_ip_addresses = string
  }))
  default = null
}

variable "subnet" {
  type = list(object({
    name                              = string
    address_prefixes                  = list(string)
    security_group                    = optional(string)
    route_table_id                    = optional(string)
    default_outbound_access_enabled   = optional(bool, true)
    private_endpoint_network_policies = optional(string, "Disabled")
    service_endpoints                 = optional(list(string))
    service_endpoint_policy_ids       = optional(list(string))
    delegations = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })), null)
  }))
  default = null

}

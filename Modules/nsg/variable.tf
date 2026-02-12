variable "nsg_name" {
  description = "The name of the resource group where the NSG will be cretaed"
  type = string
}
variable "location" {
  description = "The location where the NSG will be created"
  type = string
}
variable "resource_group_name" {
    description = "The name of the resource group where the NSG will be created"
    type = string
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type = map(string)
  default = {}
}

variable "security_rule" {
  description = "Inline security rules for the NSG. Set [] to remove all rules. Set null to ignore."
  type = list(object({
    name                       = string
    description                = optional(string) # Defaults to null
    protocol                   = string
    priority                   = number
    direction                  = string
    access                     = string
    source_port_range          = string
    source_port_ranges         = optional(list(string))
    destination_port_range     = optional(string)
    destination_port_ranges    = optional(list(string))
    source_address_prefix      = optional(string)
    source_address_prefixes    = optional(list(string))
    destination_address_prefix = optional(string)
    destination_address_prefixes = optional(list(string))
    destination_application_security_group_ids = optional(list(string))
    source_application_security_group_ids = optional(list(string))
  }))
  default = null
  
}
variable "subscription_id" {
  type        = string
  description = "The Subscription ID to use."
  default     = "52db85a1-799d-4e94-be9f-60f0c3d0c646"
}
variable "nsg_name" {
  type        = string
  description = "The name of the Network Security Group."
}
variable "location" {
  type        = string
  description = "The location of the Network Security Group."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which to create the Network Security Group."
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "security_rules" {
  type = list(object({
    name                                       = string
    description                                = string
    priority                                   = number
    direction                                  = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(list(string))
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(list(string))
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(list(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(list(string))
    source_application_security_group_ids      = optional(list(string))
    destination_application_security_group_ids = optional(list(string))
  }))
  default = []
}

variable "rg_name" {
  # Optional arguments
  type        = string
  default     = "ojha_rg"
  description = "Name of the resource group."
  validation {
    condition     = length(var.rg_name) > 0 && length(var.rg_name) < 20
    error_message = "Variable value must not be empty or length should be greater than 0 and is less than 20 characters."
  }
}
variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region where the resource group will be created."

}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource group."

}
variable "managed_by" {
  type        = string
  default     = null
  description = "The ID of the resource that manages this resource group."

}
variable "subscription_id" {
  type        = string
  description = "The Subscription ID to use."

}

// --- Virtual Network variables (generic + optional values exposed) ---
variable "vnet_name" {
  type        = string
  default     = "example-vnet"
  description = "Name of the virtual network."
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "List of CIDR blocks for the virtual network address space."
}

variable "vnet_dns_servers" {
  type        = list(string)
  default     = []
  description = "Optional list of custom DNS servers for the virtual network."
}

variable "vnet_tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to assign to the virtual network (merged with existing `tags`)."
}

variable "subnets" {
  type = list(map(any))
  default = [
    {
      name            = "subnet-1"
      address_prefixes = ["10.0.1.0/24"]
      service_endpoints = []
    },
    {
      name            = "subnet-2"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]
  description = <<-EOT
    A list of subnets for the virtual network. Each item is a map and may include:
      - name               (required) : string
      - address_prefixes   (required) : list(string)
      - service_endpoints  (optional) : list(string)

    You can add additional keys if supported by your provider version and
    consumption of the map in `vnet.tf`.
  EOT
}

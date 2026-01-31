variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
  default     = "ojha_vnet"

}
variable "address_space" {
  description = "The address space of the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
variable "dns_servers" {
  description = "The DNS servers for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.4", "10.0.0.5"]

}
variable "bgp_community" {
  description = "The BGP community for the Virtual Network"
  type        = string
  default     = null

}
variable "enable_ddos_protection" {
  description = "The DDoS protection plan for the Virtual Network"
  type        = string
  default     = null

}
variable "encryption" {
  description = "The encryption settings for the Virtual Network"
  type        = string
  default     = null

}
variable "edge_zone" {
  description = "The edge zone for the Virtual Network"
  type        = string
  default     = null

}
variable "flow_timeout_in_minutes" {
  description = "The flow timeout in minutes for the Virtual Network"
  type        = number
  default     = null

}
variable "private_endpoint_vnet_policies" {
  description = "The private endpoint VNet policies for the Virtual Network"
  type        = string
  default     = null

}
variable "tags" {
  description = "The tags for the Virtual Network"
  type        = map(string)
  default     = null

}
variable "sbnet1name" {
  description = "The name of the subnet1"
  type        = string
  default     = "Sbnet1"

}
variable "subscription_id" {
  description = "The subscription ID"
  type        = string
  default     = null
}
variable "address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
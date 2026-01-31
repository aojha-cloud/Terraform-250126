resource "azurerm_resource_group" "rg" {
  name       = var.rg_name
  location   = var.location
  tags       = var.tags
  managed_by = var.managed_by
}

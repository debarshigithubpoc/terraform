data "azurerm_subnet" "subnet" {
  name                 = var.private_endpoint_storage.subnet_name
  virtual_network_name = var.private_endpoint_storage.virtual_network_name
  resource_group_name  = var.private_endpoint_storage.virtual_network_rgname
}

data "azurerm_private_dns_zone" "private_endpoint" {
  name                = var.private_endpoint_storage.dnszone_name
  resource_group_name = var.private_endpoint_storage.dnszone_rg_name
}

data "azurerm_storage_account" "storage_account" {
  name                = var.private_endpoint_storage.storage_account_name
  resource_group_name = var.private_endpoint_storage.storage_account_rg
}
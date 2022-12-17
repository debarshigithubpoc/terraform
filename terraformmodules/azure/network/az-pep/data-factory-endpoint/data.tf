data "azurerm_subnet" "subnet" {
  name                 = var.data_factory_private_endpoint.subnet_name
  virtual_network_name = var.data_factory_private_endpoint.virtual_network_name
  resource_group_name  = var.data_factory_private_endpoint.virtual_network_rgname
}

data "azurerm_private_dns_zone" "private_endpoint" {
  name                = var.data_factory_private_endpoint.dnszone_name
  resource_group_name = var.data_factory_private_endpoint.dnszone_rg_name
}

data "azurerm_data_factory" "data_factory" {
  name                = var.data_factory_private_endpoint.data_factory_name
  resource_group_name = var.data_factory_private_endpoint.data_factory_rg
}
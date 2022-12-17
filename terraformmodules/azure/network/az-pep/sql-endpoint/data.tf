data "azurerm_subnet" "subnet" {
  name                 = var.private_endpoint_sql_server.subnet_name
  virtual_network_name = var.private_endpoint_sql_server.virtual_network_name
  resource_group_name  = var.private_endpoint_sql_server.virtual_network_rgname
}

data "azurerm_private_dns_zone" "private_endpoint" {
  name                = var.private_endpoint_sql_server.dnszone_name
  resource_group_name = var.private_endpoint_sql_server.dnszone_rg_name
}
data "azurerm_mssql_server" "mssql_server" {
  name                = var.private_endpoint_sql_server.sql_server_name
  resource_group_name = var.private_endpoint_sql_server.sql_server_rg
}

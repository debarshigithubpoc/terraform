resource "azurerm_private_endpoint" "pep" {
  name                = var.private_endpoint_sql_server.name
  location            = var.private_endpoint_sql_server.location
  resource_group_name = var.private_endpoint_sql_server.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = try(var.private_endpoint_sql_server.tags, null)
  private_service_connection {
    name = var.private_endpoint_sql_server.private_service_connection_name
    private_connection_resource_id = try(data.azurerm_storage_account.storage_account.id)
    is_manual_connection = try(var.private_endpoint_sql_server.private_service_manual_connection, false)
    subresource_names    = var.private_endpoint_sql_server.subresource_names
    request_message      = try(var.private_endpoint_sql_server.request_message, null)
  }
  dynamic "private_dns_zone_group" {
    for_each = try(var.private_endpoint_sql_server.private_dns_zone_group, null) != null ? [var.private_endpoint_sql_server.private_dns_zone_group] : []
    content {
      name = try(private_dns_zone_group.value.name, null)
      private_dns_zone_ids = flatten([
        [
          data.azurerm_private_dns_zone.private_endpoint.id
        ]
      ])
    }
  }
}
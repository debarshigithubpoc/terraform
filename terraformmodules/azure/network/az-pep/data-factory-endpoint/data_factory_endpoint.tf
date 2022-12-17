resource "azurerm_private_endpoint" "pep" {
  name                = var.data_factory_private_endpoint.name
  location            = var.data_factory_private_endpoint.location
  resource_group_name = var.data_factory_private_endpoint.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet.id
  tags                = try(var.data_factory_private_endpoint.tags, null)
  private_service_connection {
    name = var.data_factory_private_endpoint.private_service_connection_name
    private_connection_resource_id = try(data.azurerm_storage_account.storage_account.id)
    is_manual_connection = try(var.data_factory_private_endpoint.private_service_manual_connection, false)
    subresource_names    = var.data_factory_private_endpoint.subresource_names
    request_message      = try(var.data_factory_private_endpoint.request_message, null)
  }
  dynamic "private_dns_zone_group" {
    for_each = try(var.data_factory_private_endpoint.private_dns_zone_group, null) != null ? [var.data_factory_private_endpoint.private_dns_zone_group] : []
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
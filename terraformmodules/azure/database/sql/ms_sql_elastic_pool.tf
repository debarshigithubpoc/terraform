resource "azurerm_mssql_elasticpool" "elastic_pool" {
  for_each            = var.ms_sql_elasticpool
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  server_name         = azurerm_mssql_server.mssqlserver.name
  license_type        = try(each.value.license_type,"LicenseIncluded")
  max_size_gb         = try(each.value.max_size_gb,50)
  sku {
    name     = try(each.value.sku_name,"GP_Gen5")
    tier     = try(each.value.sku_tier,"GeneralPurpose")
    family   = try(each.value.sku_family,"Gen5")
    capacity = try(each.value.sku_capacity,4)
  }

  per_database_settings {
    min_capacity = try(each.value.per_database_min_capacity,0.25)
    max_capacity = try(each.value.per_database_max_capacity,4)
  }
}


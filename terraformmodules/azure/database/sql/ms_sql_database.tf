resource "azurerm_mssql_database" "mssql_database" {
  for_each                       = var.ms_sql_database
  name                           = "sqldev-la-${each.value.env}-uks-${each.value.instance_number}"
  server_id                      = azurerm_mssql_server.mssqlserver.id
  collation                      = try(each.value.collation, "SQL_Latin1_General_CP1_CI_AS")
  license_type                   = try(each.value.license_type, "LicenseIncluded")
  max_size_gb                    = try(each.value.max_size_gb, 32)
  create_mode                    = try(each.value.create_mode, "Default")
  sku_name                       = try(each.value.sku_name, "S0")
  read_scale                     = try(each.value.read_scale, false)
  zone_redundant                 = try(each.value.zone_redundant, false)
  elastic_pool_id                = try(each.value.elastic_pool_id, null)
  geo_backup_enabled             = try(each.value.geo_backup_enabled, false)
  ledger_enabled                 = try(each.value.ledger_enabled, false)
  restore_point_in_time          = try(each.value.restore_point_in_time, null)
  recover_database_id            = try(each.value.recover_database_id, null)
  restore_dropped_database_id    = try(each.value.restore_dropped_database_id, null)
  read_replica_count             = try(each.value.read_replica_count, null)
  tags                           = try(each.value.tags, null)
}


## Azure Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                              = "strgla${var.storage_account.env}uks${var.storage_account.instance_number}"
  location                          = var.storage_account.location
  resource_group_name               = var.storage_account.resource_group_name
  is_hns_enabled                    = try(var.storage_account.is_hns_enabled, true)
  access_tier                       = try(var.storage_account.access_tier, "Hot")
  account_kind                      = try(var.storage_account.account_kind, "StorageV2")
  account_replication_type          = try(var.storage_account.account_replication_type, "LRS")
  account_tier                      = try(var.storage_account.account_tier, "Standard")
  enable_https_traffic_only         = try(var.storage_account.enable_https_traffic_only, true)
  infrastructure_encryption_enabled = try(var.storage_account.infrastructure_encryption_enabled, null)
  large_file_share_enabled          = try(var.storage_account.large_file_share_enabled, null)
  min_tls_version                   = try(var.storage_account.min_tls_version, "TLS1_2")
  nfsv3_enabled                     = try(var.storage_account.nfsv3_enabled, false)
  queue_encryption_key_type         = try(var.storage_account.queue_encryption_key_type, null)
  table_encryption_key_type         = try(var.storage_account.table_encryption_key_type, null)
  tags                              = try(var.storage_account.tags, null)
}
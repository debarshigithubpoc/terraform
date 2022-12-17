data "azurerm_storage_account" "storage_account" {
  for_each            = var.azure_data_lake
  name                = each.value.storage_account_name
  resource_group_name = each.value.storage_account_rg
}
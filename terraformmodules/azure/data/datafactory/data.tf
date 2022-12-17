## Query existing Keyvault
data "azurerm_key_vault" "keyvault" {
  name                = var.data_factory_linkedservices_kv.keyvault_name
  resource_group_name = var.data_factory_linkedservices_kv.keyvault_rg
}

data "azurerm_storage_account" "storage_account" {
  for_each            = var.data_factory_linkedservices_datalake
  name                = each.value.storage_account_name
  resource_group_name = each.value.storage_account_rg
}


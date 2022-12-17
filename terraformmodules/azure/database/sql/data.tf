data "azurerm_subnet" "subnet" {
  for_each             = var.ms_sql_server_vnet_rule
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.virtual_network_rgname
}

data "azurerm_key_vault" "keyvault" {
  name                = var.ms_sql_server.key_vault_name
  resource_group_name = var.ms_sql_server.key_vault_rg
}

data "azurerm_key_vault_secret" "keyvault_sercret" {
  name         = var.ms_sql_server.sql_secret
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
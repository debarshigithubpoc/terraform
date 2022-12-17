## Azure data factory Linked Services

## Keyvault Linked service for getting secrets to link other services
resource "azurerm_data_factory_linked_service_key_vault" "linked_keyvault" {
  name            = "lskv-la-${var.data_factory_linkedservices_kv.env}-uks-${var.data_factory_linkedservices_kv.instance_number}"
  data_factory_id = azurerm_data_factory.data_factory.id
  key_vault_id    = data.azurerm_key_vault.keyvault.id
}

## Azure Sql server linked service
resource "azurerm_data_factory_linked_service_sql_server" "linked_service_sql_server" {
  for_each                 = var.data_factory_linkedservices_sql
  name                     = "lssql-la-${each.value.env}-uks-${each.value.instance_number}"
  connection_string        = each.value["connection_string"]  
  data_factory_id          = azurerm_data_factory.data_factory.id
  description              = try(each.value["description"], null)
  integration_runtime_name = try(each.value["integration_runtime_name"], null)
  annotations              = try(each.value["annotations"], null)
  parameters               = try(each.value["parameters"], null)
  additional_properties    = try(each.value["additional_properties"], null)
  key_vault_password {
    linked_service_name = azurerm_data_factory_linked_service_key_vault.linked_keyvault.name
    secret_name         = each.value.kv_secret_name
  }

}

## Azure data lake linked service
resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "linked_service_data_lake_storage_gen2" {
  for_each                 = var.data_factory_linkedservices_datalake
  name                     = "lsadl-la-${each.value.env}-uks-${each.value.instance_number}"
  url                      = each.value.url
  data_factory_id          = azurerm_data_factory.data_factory.id
  storage_account_key      = data.azurerm_storage_account.storage_account[each.key].primary_access_key
  description              = try(each.value["description"], null)
  integration_runtime_name = try(each.value["integration_runtime_name"], null)
  annotations              = try(each.value["annotations"], null)
  parameters               = try(each.value["parameters"], null)
  additional_properties    = try(each.value["additional_properties"], null)
}
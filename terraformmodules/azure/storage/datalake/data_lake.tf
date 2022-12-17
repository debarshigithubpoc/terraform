resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake" {
  for_each           = var.azure_data_lake
  name               = "adl-la-${each.value.env}-uks-${each.value.instance_number}"
  storage_account_id = data.azurerm_storage_account.storage_account[each.key].id
  properties         = try(each.value["properties"],null)
}


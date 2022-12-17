## Azure storage container
resource "azurerm_storage_container" "container" {
  for_each              = var.storage_account_containers
  name                  = "stco-la-${each.value.env}-uks-${each.value.instance_number}"
  storage_account_name  = each.value["storage_account_name"]
  container_access_type = try(each.value["container_access_type"],"private")
  depends_on = [
    azurerm_storage_account.storage_account
  ]
}
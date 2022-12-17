resource "azurerm_search_service" "ss" {
    for_each                      = var.search_service
    name                          = "srch-la-${each.value.env}-uks-${each.value.instance_number}"
    resource_group_name           = each.value["resource_group"]
    location                      = each.value["location"]
    sku                           = try(each.value["sku"], "free")
    public_network_access_enabled = try(each.value["public_network_access_enabled"], "true")
    replica_count                 = try(each.value["replica_count"], 1)
    partition_count               = try(each.value["partition_count"], 1)
}
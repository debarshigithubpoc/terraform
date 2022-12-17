resource "azurerm_service_plan" "service_plan" {
    for_each            = var.service_plan
    name                = "asp-la-${each.value.env}-uks-${each.value.instance_number}"
    resource_group_name = each.value["resource_group"]
    location            = each.value["location"]
    os_type             = try(each.value["os_type"], "Linux")
    sku_name            = try(each.value["sku"], "B1")
}
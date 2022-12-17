# Get Existing Resource Groups
data "azurerm_resource_group" "virtual_networks" {
    for_each = var.virtual_networks
    name = each.value.resource_group_name
}
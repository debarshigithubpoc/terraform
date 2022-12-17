# Module for creating Virtual Networks
resource "azurerm_virtual_network" "vnet" {
  for_each            = var.virtual_networks
  name                = each.value["name"]
  location            = try(each.value.location , data.azurerm_resource_group.virtual_networks[each.key].location)
  resource_group_name = data.azurerm_resource_group.virtual_networks[each.key].name
  address_space       = each.value["address_space"]
  dns_servers         = lookup(each.value, "dns_servers", null)
  ## Inherit Resource Group tags and merge them to additonal tags supplied for vnet
  tags                = merge(data.azurerm_resource_group.virtual_networks[each.key].tags,each.value["tags"])
}




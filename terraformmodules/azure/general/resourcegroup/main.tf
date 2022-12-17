locals {
    defaultrgtags = {
      Environment   = "Development"
      CostCenter    = "Department"
      ResourceOwner = "Example Owner"
      Project       = "Example Project Name"
      Role          = "Resource Group"
    }
}

resource "azurerm_resource_group" "rg" {
  for_each = var.resource_group
  name     = "rg-la-${each.value.env}-uks-${each.value.instance_number}"
  location = each.value["location"]
  tags     = merge(local.defaultrgtags,try(each.value["tags"], null))
}


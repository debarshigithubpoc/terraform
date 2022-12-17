data "azurerm_service_plan" "linux_web_app" {
    for_each               = var.linux_web_app
    name                   = each.value.service_plan_name
    resource_group_name    = each.value.service_plan_rg
}
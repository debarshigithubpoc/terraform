module "resource_group" {
  source         = "../terraformmodules/azure/general/resourcegroup"
  resource_group = try(var.resource_group, {})
}

module "storage_accounts" {
  source                     = "../terraformmodules/azure/storage/storageaccount"
  for_each                   = var.storage_accounts
  storage_account            = try(each.value.storage_account, {})
  storage_account_containers = try(each.value.storage_account_containers, {})
  depends_on = [
    module.resource_group
  ]
}

module "data_lake" {
  source          = "../terraformmodules/azure/storage/datalake"
  azure_data_lake = try(var.azure_data_lake, {})
  depends_on = [
    module.resource_group,
    module.storage_accounts
  ]
}

module "ms_sql_server" {
  source                      = "../terraformmodules/azure/database/sql"
  for_each                    = var.sql_servers
  ms_sql_server               = try(each.value.ms_sql_server, {})
  ms_sql_database             = try(each.value.ms_sql_database, {})
  ms_sql_elasticpool          = try(each.value.ms_sql_elasticpool, {})
  ms_sql_server_firewall_rule = try(each.value.ms_sql_server_firewall_rule, {})
  ms_sql_server_vnet_rule     = try(each.value.ms_sql_server_vnet_rule, {})
  depends_on = [
    module.resource_group,
    module.storage_accounts,
  ]
}

module "data_factory" {
  source                               = "../terraformmodules/azure/data/datafactory"
  for_each                             = var.data_factorys
  data_factory                         = try(each.value.data_factory, {})
  data_factory_pipelines               = try(each.value.data_factory_pipelines, {})
  data_factory_integration_runtime     = try(each.value.data_factory_integration_runtime, {})
  data_factory_linkedservices_sql      = try(each.value.data_factory_linkedservices_sql, {})
  data_factory_linkedservices_datalake = try(each.value.data_factory_linkedservices_datalake, {})
  data_factory_ssis                    = try(each.value.data_factory_ssis, {})
  data_factory_trigger_schedule        = try(each.value.data_factory_trigger_schedule, {})
  data_factory_linkedservices_kv       = try(each.value.data_factory_linkedservices_kv, {})
  depends_on = [
    module.resource_group,
    module.storage_accounts,
    module.ms_sql_server,
    module.data_lake
  ]
}

module "api_management" {
  source         = "../terraformmodules/azure/paas/apimanagement"
  for_each       = var.api_managements
  api_management = try(each.value.api_management, {})
  depends_on = [
    module.resource_group
  ]
}

module "search_service" {
  source         = "../terraformmodules/azure/pass/searchservice"
  search_service = try(var.search_service, {})
  depends_on = [
    module.resource_group
  ]
}

module "az_service_plan" {
  source       = "../terraformmodules/azure/webapp/appserviceplan"
  service_plan = try(var.service_plan, {})
  depends_on = [
    module.resource_group
  ]
}

module "app_service_linux" {
  source        = "../terraformmodules/azure/webapp/appservice-linux"
  linux_web_app = try(var.linux_web_app, {})
  depends_on = [
    module.resource_group,
    module.az_service_plan
  ]
}

module "app_service_windows" {
  source        = "../terraformmodules/azure/webapp/appservice-windows"
  windows_web_app = try(var.windows_web_app, {})
  depends_on = [
    module.resource_group,
    module.az_service_plan
  ]
}


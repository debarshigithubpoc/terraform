## Azure data factory Pipeline

resource "azurerm_data_factory_pipeline" "pipeline" {
  for_each                       = var.data_factory_pipelines
  name                           = each.value["name"]
  data_factory_id                = azurerm_data_factory.data_factory.id
  description                    = try(each.value["description"], null)
  annotations                    = try(each.value["annotations"], null)
  concurrency                    = try(each.value["concurrency"], null)
  folder                         = try(each.value["folder"], null)
  moniter_metrics_after_duration = try(each.value["moniter_metrics_after_duration"], null)
  parameters                     = try(each.value["parameters"], null)
  variables                      = try(each.value["variables"], null)
  activities_json                = try(each.value["activities_json"], null)
}
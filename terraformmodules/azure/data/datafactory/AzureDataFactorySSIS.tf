## Azure data factory SSIS 
resource "azurerm_data_factory_integration_runtime_azure_ssis" "ssis_vm" {
  for_each                         = var.data_factory_ssis
  name                             = each.value.name
  location                         = each.value.location
  data_factory_id                  = azurerm_data_factory.data_factory.id
  node_size                        = try(each.value["node_size"],"Standard_D8_v3")
  number_of_nodes                  = try(each.value["number_of_nodes"], 1)
  max_parallel_executions_per_node = try(each.value["max_parallel_executions_per_node"], 2)
  edition                          = try(each.value["edition"], null)
  license_type                     = try(each.value["license_type"], null)
}


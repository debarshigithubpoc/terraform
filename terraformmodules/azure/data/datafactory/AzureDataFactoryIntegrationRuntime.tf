## Azure data factory Self hosted integration runtime

resource "azurerm_data_factory_integration_runtime_self_hosted" "selfhostedintegrationruntime" {
  for_each        = var.data_factory_integration_runtime 
  data_factory_id = azurerm_data_factory.data_factory.id
  name            = each.value.name
}



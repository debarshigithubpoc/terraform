## Azure data factory Trigger Schedule

resource "azurerm_data_factory_trigger_schedule" "trigger_schedule" {
  for_each            = var.data_factory_trigger_schedule
  name                = each.value.name
  data_factory_id     = azurerm_data_factory.data_factory.id
  pipeline_name       = each.value.pipeline_name
  start_time          = try(each.value["start_time"], null)
  end_time            = try(each.value["end_time"], null)
  interval            = try(each.value["interval"], null)
  frequency           = try(each.value["frequency"], null)
  pipeline_parameters = try(each.value["pipeline_parameters"], null)
  annotations         = try(each.value["annotations"], null)
}
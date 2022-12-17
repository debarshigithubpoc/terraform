resource "azurerm_windows_web_app" "windows_web_app" {
  for_each            = var.windows_web_app
  name                = "ase-la-${each.value.env}-uks-${each.value.instance_number}"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  service_plan_id     = data.azurerm_service_plan.windows_web_app[each.key].id
  https_only = try(each.value["https_only"], true)

  dynamic "identity" {
    for_each = lookup(each.value, "identity", null) != null ? [1] : []
    content {
      type         = each.value.identity.type
      identity_ids = try(each.value.identity.identity_ids, null)
    }
  }

  dynamic "site_config" {
    for_each = lookup(each.value, "site_config", null) != {} ? [1] : []

    content {
      always_on                = try(each.value.site_config.always_on, false)
      worker_count             = try(each.value.site_config.worker_count, 1)
      app_command_line         = try(each.value.site_config.app_command_line, null)
      default_documents        = try(each.value.site_config.default_documents, null)
      ftps_state               = try(each.value.site_config.ftps_state, "FtpsOnly")
      health_check_path        = try(each.value.site_config.health_check_path, null)
      http2_enabled            = try(each.value.site_config.http2_enabled, false)
      managed_pipeline_mode    = try(each.value.site_config.managed_pipeline_mode, null)
      minimum_tls_version      = try(each.value.site_config.minimum_tls_version, "1.2")
      remote_debugging_enabled = try(each.value.site_config.remote_debugging_enabled, false)
      remote_debugging_version = try(each.value.site_config.remote_debugging_version, null)
      websockets_enabled       = try(each.value.site_config.websockets_enabled, false)
      application_stack {
        current_stack  = try(each.value.site_config.application_stack.current_stack, "dotnet")
        dotnet_version = try(each.value.site_config.application_stack.dotnet_version, "v6.0")
      }
    }
  }

  dynamic "connection_string" {
    for_each = lookup(each.value, "connection_string", null) != {} ? [1] : []
    #for_each = try(each.value.connection_string, null) != null ? [each.value.connection_string] : []

    content {
      name  = try(each.value.connection_string.name, null)
      type  = try(each.value.connection_string.type, null)
      value = try(each.value.connection_string.value, null)
    }
  }
}

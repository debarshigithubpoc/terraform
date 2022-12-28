## Azure data factory

resource "azurerm_data_factory" "data_factory" {
  name                = "adf-deb-${var.data_factory.env}-us-${var.data_factory.instance_number}"
  resource_group_name = var.data_factory.resource_group_name
  location            = var.data_factory.location

  dynamic "github_configuration" {
    for_each = try(var.data_factory.github_configuration, null) != null ? [var.data_factory.github_configuration] : []

    content {
      account_name    = github_configuration.value.account_name
      branch_name     = github_configuration.value.branch_name
      git_url         = github_configuration.value.git_url
      repository_name = github_configuration.value.repository_name
      root_folder     = github_configuration.value.root_folder
    }
  }
  dynamic "global_parameter" {
    for_each = try(var.data_factory.global_parameter, null) != null ? [var.data_factory.global_parameter] : []

    content {
      name  = global_parameter.value.name
      type  = global_parameter.value.type
      value = global_parameter.value.value
    }
  }
  dynamic "identity" {
    for_each = try(var.data_factory.identity, null) != null ? [var.data_factory.identity] : []
    content {
      type         = try(identity.value.type , "SystemAssigned")
      identity_ids = try(identity.value.identity_ids , null)
    }
  }

  dynamic "vsts_configuration" {
    for_each = try(var.data_factory.vsts_configuration, null) != null ? [var.data_factory.vsts_configuration] : []

    content {
      account_name    = vsts_configuration.value.account_name
      branch_name     = vsts_configuration.value.branch_name
      project_name    = vsts_configuration.value.project_name
      repository_name = vsts_configuration.value.repository_name
      root_folder     = vsts_configuration.value.root_folder
      tenant_id       = vsts_configuration.value.tenant_id
    }
  }
  managed_virtual_network_enabled = try(var.data_factory.managed_virtual_network_enabled, true)
  public_network_enabled          = try(var.data_factory.public_network_enabled, false)
  tags                            = try(var.data_factory.tags, null)
}





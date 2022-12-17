## Grant ADF system identity to keyvault access policy
resource "azurerm_key_vault_access_policy" "access_policy" {
  key_vault_id = data.azurerm_key_vault.keyvault.id
  tenant_id    = azurerm_data_factory.data_factory.identity[0].tenant_id
  object_id    = azurerm_data_factory.data_factory.identity[0].principal_id
  secret_permissions = [
    "Get","List"
  ]
}

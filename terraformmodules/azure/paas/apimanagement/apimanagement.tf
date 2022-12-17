resource "azurerm_api_management" "api_management" {
  name                          = "apimgla${var.api_management.env}uks${var.api_management.instance_number}"
  location                      = var.api_management.location
  resource_group_name           = var.api_management.resource_group_name
  publisher_name                = var.api_management.publisher_name
  publisher_email               = var.api_management.publisher_email
  sku_name                      = try(var.api_management.sku_name,"Standard_1")
  min_api_version               = try(var.api_management.min_api_version,null)
  notification_sender_email     = try(var.api_management.notification_sender_email, null)
  public_network_access_enabled = try(var.api_management.public_network_access_enabled, true)

    dynamic "hostname_configuration" {
    for_each = try(var.api_management.hostname_configuration, null) != null ? [var.api_management.hostname_configuration] : []
    content {

        dynamic "management" {
            for_each = try(var.api_management.hostname_configuration.management, null) != null ? [var.api_management.hostname_configuration.management] : []
            content {
            host_name                    = try(management.value.host_name, null)
            key_vault_id                 = try(management.value.key_vault_id, null)
            certificate                  = try(management.value.certificate, null)
            certificate_password         = try(management.value.certificate_password, null)
            }
        }

        dynamic "portal" {
            for_each = try(var.api_management.hostname_configuration.portal, null) != null ? [var.api_management.hostname_configuration.portal] : []
            content {
                host_name                    = try(portal.value.host_name, null)
                key_vault_id                 = try(portal.value.key_vault_id, null)
                certificate                  = try(portal.value.certificate, null)
                certificate_password         = try(portal.value.certificate_password, null)
                negotiate_client_certificate = try(portal.value.negotiate_client_certificate, true)
            }
        }
        dynamic "developer_portal" {
            for_each = try(var.api_management.hostname_configuration.developer_portal, null) != null ? [var.api_management.hostname_configuration.developer_portal] : []
            content {
                host_name                    = try(developer_portal.value.host_name, null)
                key_vault_id                 = try(developer_portal.value.key_vault_id, null)
                certificate                  = try(developer_portal.value.certificate, null)
                certificate_password         = try(developer_portal.value.certificate_password, null)
                negotiate_client_certificate = try(developer_portal.value.negotiate_client_certificate, true)
            }
        }

        dynamic "proxy" {
        for_each = try(var.api_management.hostname_configuration.proxy, null) != null ? [var.api_management.hostname_configuration.proxy] : []
            content {
                default_ssl_binding          = try(proxy.value.default_ssl_binding, null)
                host_name                    = try(proxy.value.host_name, null)
                key_vault_id                 = try(proxy.value.key_vault_id, null)
                certificate                  = try(proxy.value.certificate, null)
                certificate_password         = try(proxy.value.certificate_password, null)
                negotiate_client_certificate = try(proxy.value.negotiate_client_certificate, true)
            }
        }

        dynamic "scm" {
        for_each = try(var.api_management.hostname_configuration.scm, null) != null ? [var.api_management.hostname_configuration.scm] : []
        content {
            host_name                    = try(scm.value.host_name, null)
            key_vault_id                 = try(scm.value.key_vault_id, null)
            certificate                  = try(scm.value.certificate, null)
            certificate_password         = try(scm.value.certificate_password, null)
            negotiate_client_certificate = try(scm.value.negotiate_client_certificate, true)
            }
        }
        }
    }

    dynamic "identity" {
        for_each = try(var.api_management.identity, null) != null ? [var.api_management.identity] : []
        content {
        type         = try(identity.value.type , "SystemAssigned")
        identity_ids = try(identity.value.identity_ids , null)
        }
    }

    dynamic "policy" {
        for_each = try(var.api_management.policy, null) != null ? [var.api_management.policy] : []
        content {
        xml_content = try(policy.value.xml_content, null)
        xml_link    = try(policy.value.xml_link, null)
        }
    }

    dynamic "protocols" {
        for_each = try(var.api_management.protocols, null) != null ? [var.api_management.protocols] : []
        content {
        enable_http2 = try(protocols.value.enable_http2, null)
        }
    }
    
    dynamic "security" {
        for_each = try(var.api_management.security, null) != null ? [var.api_management.security] : []
        content {

        enable_backend_ssl30                                = try(security.value.enable_backend_ssl30, null)
        enable_backend_tls10                                = try(security.value.enable_backend_tls10, null)
        enable_backend_tls11                                = try(security.value.enable_backend_tls11, null)
        enable_frontend_ssl30                               = try(security.value.enable_frontend_ssl30, null)
        enable_frontend_tls10                               = try(security.value.enable_frontend_tls10, null)
        enable_frontend_tls11                               = try(security.value.enable_frontend_tls11, null)
        tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = try(security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled, null)
        tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = try(security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled, null)
        tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = try(security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled, null)
        tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = try(security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled, null)
        tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = try(security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled, null)
        tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = try(security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled, null)
        tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = try(security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled, null)
        tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = try(security.value.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled, null)
        tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = try(security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled, null)
        #enable_triple_des_ciphers                           = try(security.value.enable_triple_des_ciphers, null)
        triple_des_ciphers_enabled                          = try(security.value.triple_des_ciphers_enabled, null)
        # disable_backend_ssl30                               = try(security.value.disable_backend_ssl30, null)
        # disable_backend_tls10                               = try(security.value.disable_backend_tls10, null)
        # disable_backend_tls11                               = try(security.value.disable_backend_tls11, null)
        # disable_frontend_ssl30                              = try(security.value.disable_frontend_ssl30, null)
        # disable_frontend_tls10                              = try(security.value.disable_frontend_tls10, null)
        # disable_frontend_tls11                              = try(security.value.disable_frontend_tls11, null)
        }
    }

 tags = try(var.api_management.tags, null)

}
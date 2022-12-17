## Resource Groups
resource_group = {
  rg1 = {
    env             = "dev"
    instance_number = "01"
    location        = "eastus"
  }
}

## Deploy a Storage Accounts with 2 Containers
storage_accounts = {
  st1 = {

    storage_account = {
      env                 = "dev"
      instance_number     = "01"
      location            = "eastus"
      resource_group_name = "rg-la-dev-uks-01"
    }

    storage_account_containers = {
      container1 = {
        env                  = "dev"
        instance_number      = "01"
        storage_account_name = "strgladevuks01"
      }
      container2 = {
        env                  = "dev"
        instance_number      = "02"
        storage_account_name = "strgladevuks01"
      }

    }
  }
}

## Enable Data Lake for the above Storage Account

azure_data_lake = {
  datalake1 = {
    env                  = "dev"
    instance_number      = "01"
    storage_account_name = "strgladevuks01"
    storage_account_rg   = "rg-la-dev-uks-01"
  }
}


## Deploy a SQL Server with 2 SQL Databases
sql_servers = {
  sql_server1 = {
    ms_sql_server = {
      ## Mention the SQL server name , rg , location , admin username and password from keyvault secret
      env                 = "dev"
      instance_number     = "01"
      resource_group_name = "rg-la-dev-uks-01"
      location            = "eastus"
      administrator_login = "azureadminlg"
      key_vault_name      = "keyvaultname"
      key_vault_rg        = "rg1"
      sql_secret          = "sqlpassword"
      # administrator_login_password = "Farcry$456889"
      identity = {
        ## Enable system managed identity for SQL Server
        type = "SystemAssigned"
      }

    }

    ## Mention the allowed ip from where the sql server will be accessed
    ms_sql_server_firewall_rule = {
      fwrule1 = {
        env              = "dev"
        instance_number  = "01"
        start_ip_address = "0.0.0.0"
        end_ip_address   = "0.0.0.0"
      }
      fwrule2 = {
        env              = "dev"
        instance_number  = "02"
        start_ip_address = "116.193.130.116"
        end_ip_address   = "116.193.130.116"
      }
    }

    ## Mentioned the informations for creating the sql database in the sql server
    ms_sql_database = {
      sqldb1 = {
        env                = "dev"
        instance_number    = "01"
        collation          = "SQL_Latin1_General_CP1_CI_AS"
        license_type       = "LicenseIncluded"
        max_size_gb        = 5
        sku_name           = "S0"
        geo_backup_enabled = true
      }
    }

  }

}

## Deploy a Data Factory with Github Integration and 3 Linked Services Keyvault , SQL Server and Azure Data Lake
data_factorys = {
  df1 = {
    data_factory = {
      env                 = "dev"
      instance_number     = "01"
      resource_group_name = "rg-la-dev-uks-01"
      location            = "eastus"

      identity = {
        ## Enable system managed identity for Data Factory
        type = "SystemAssigned"
      }

      github_configuration = {

        #NOTE: Authorize the github Account from portal

        ## Github Account name        
        account_name = "debarshidevopskubernetes"
        branch_name  = "main"

        ## Specifiy the GitHub Enterprise host name. For example: https://github.mydomain.com. 
        ## Use https://github.com for open source repositories.
        git_url = "https://github.com"

        # Github Repo name
        repository_name = "terraform_test_jenkins"
        root_folder     = "/"
      }

    }

    ## Enable linked service for keyvault
    data_factory_linkedservices_kv = {
      env             = "dev"
      instance_number = "01"
      keyvault_name   = "keyvaultname"
      keyvault_rg     = "rg1"
    }

    ## Enable linked service for SQL Server by password from keyvault
    data_factory_linkedservices_sql = {
      sqllinked1 = {
        env               = "dev"
        instance_number   = "01"
        connection_string = "data source=sqlsrv-la-dev-uks-01.database.windows.net;initial catalog=sqldev-la-dev-uks-01;user id=azureadminlg;integrated security=True;encrypt=True;connection timeout=30"
        description       = "Azure SQL details"
        kv_secret_name    = "sqlpassword"
      }
    }

    # ## Enable linked service for Azure Data Lake
    data_factory_linkedservices_datalake = {
      datalake1 = {
        env                  = "dev"
        instance_number      = "01"
        url                  = "https://strgladevuks01.dfs.core.windows.net"
        description          = "Azure DataLake details"
        storage_account_name = "strgladevuks01"
        storage_account_rg   = "rg-la-dev-uks-01"
      }
    }
  }

}

# API Management with management portal and Developer Portal
# Takes 2 hours to provision using Terraform 

api_managements = {
  apim1 = {
    api_management = {
      env                 = "dev"
      instance_number     = "01"
      location            = "eastus"
      resource_group_name = "rg-la-dev-uks-01"
      publisher_name      = "debarshiself"
      publisher_email     = "debarshi.eee@gmail.com"
      sku_name            = "Standard_1"
      identity = {
        type = "SystemAssigned"
      }
    }
  }

}

# ## Azure Search Service 
search_service = {
  ss1 = {
    env                           = "dev"
    instance_number               = "01"
    resource_group                = "rg-la-dev-uks-01"
    location                      = "uksouth"
    sku                           = "standard"
    public_network_access_enabled = false
    replica_count                 = 1
    partition_count               = 1
  }
}

 service_plan = {
  ## Azure Linux App service plan
    sp1 = {
      env             = "dev"
      instance_number = "02"
      resource_group  = "rg-la-dev-uks-01"
      location        = "uksouth"
      os_type         = "Linux"
      sku_name        = "B1"
    }
  ## Azure Windows App service plan
    sp2 = {
      env             = "dev"
      instance_number = "01"
      resource_group  = "rg-la-dev-uks-01"
      location        = "uksouth"
      os_type         = "Windows"
      sku_name        = "F1"

    }
 }

# ## Azure Linux web app

linux_web_app = {
  web_app1 = {
    env               = "dev"
    instance_number   = "02"
    resource_group    = "rg-la-dev-uks-01"
    location          = "uksouth"
    service_plan_name = "asp-la-dev-uks-02"
    service_plan_rg   = "rg-la-dev-uks-01"

    connection_string = {}

    identity = {
      type = "SystemAssigned"
    }

    site_conf = {
      always_on                = true
      worker_count             = 1
      ftps_state               = "Disbaled"
      http2_enabled            = false
      minimum_tls_version      = "1.2"
      remote_debugging_enabled = false
      remote_debugging_version = "VS2019"
    }
  }
}

# ## Azure Windows web app

windows_web_app = {
  web_app1 = {
    env               = "dev"
    instance_number   = "01"
    resource_group_name    = "rg-la-dev-uks-01"
    location          = "uksouth"
    service_plan_name = "asp-la-dev-uks-01"
    service_plan_rg   = "rg-la-dev-uks-01"

    connection_string = {}

    identity = {
      type = "SystemAssigned"
    }

    site_conf = {
      always_on                = true
      worker_count             = 1
      ftps_state               = "Disbaled"
      http2_enabled            = false
      minimum_tls_version      = "1.2"
      remote_debugging_enabled = false
      remote_debugging_version = "VS2019"
      application_stack = {
        current_stack         = "dotnet"
        dotnet_version        = "v6.0"
      }
    }
  }
}
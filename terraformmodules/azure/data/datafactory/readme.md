**Sample tfvar file for Azure Data Factory**

```
data_factories = {
  data_factory1 = {
    data_factory_name     = "adfambg1"
    data_factory_location = "EastUS2"
    data_factory_rg_name  = "test-rg-lbvm"

    managed_virtual_network_enabled = ""
    github_configuration = {
     account_name = ""
     branch_name = ""
     git_url = ""
     repository_name = ""
     root_folder = ""
    }

    global_parameter = {
     name= ""
     type = ""
     value = ""
    }

    identity = {
      type = "SystemAssigned"
       identity_name = ""
       identity_rg_name = "" 
    }

    vsts_configuration = {
     account_name = ""
     branch_name = ""
     project_name = ""
     repository_name = ""
     root_folder = ""
     tenant_id = ""
    }
}
```
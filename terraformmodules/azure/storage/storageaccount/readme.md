**Sample tfvar file for Azure Resource Group**
```
storage_accounts = {
st1 = {
  storage_account = {
  name                = "strgdevmhr45"
  location            = "eastus"
  resource_group_name = "rg1"
  }
  storage_account_containers = {
   container1 = {
    name = "container1"
    storage_account_name = "strgdevmhr45"
   }
   container2 = {
    name = "container2"
    storage_account_name = "strgdevmhr45"    
   }

  }
}

st2 = {
  storage_account = {
  name                = "strgdevmhr47"
  location            = "eastus"
  resource_group_name = "rg1"
  }
  }
}
```
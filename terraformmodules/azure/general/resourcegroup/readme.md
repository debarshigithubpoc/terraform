**Sample tfvar file for Azure Resource Group**
```
resource_group = {
  rg1 = {
    name     = "rg1"
    location = "eastus"
  }
  rg2 = {
    name     = "rg2"
    location = "eastus"
    tags = {
      env = "dev"
    }
  }
}
```
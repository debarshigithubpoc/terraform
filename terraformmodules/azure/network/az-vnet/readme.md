**Sample tfvar file for Azure Virtual Network**
```
virtual_networks = {
  vnet1 = {
    name = "vnet"
    location = "eastus"
    resource_group_name = "rg2"
    address_space = ["10.1.0.0/16"]
    dns_servers   = []
    tags = {
      vnet = "dev"
    }
  }
}
```
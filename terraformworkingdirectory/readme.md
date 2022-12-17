## Initialize using different backend

set environment variable for Terraform azure authentication for dev

terraform init -backend-config="resource_group_name=rg1" -backend-config="storage_account_name=strgstatefiledev" -backend-config="container_name=container1" -backend-config="key=dev.terraform.tfstate"

terraform apply -var-file=”terraformdev.tfvars” --auto-approve 

terraform destroy -var-file=”terraformdev.tfvars” --auto-approve 

=====================================================================================================

set environment variable for Terraform azure authentication for prod

terraform init -reconfigure -backend-config="resource_group_name=rg1" -backend-config="storage_account_name=strgstatefiledev" -backend-config="container_name=container1" -backend-config="key=prod.terraform.tfstate"

terraform apply -var-file=”terraformprod.tfvars” --auto-approve

terraform destroy -var-file=”terraformprod.tfvars” --auto-approve

=====================================================================================================

set environment variable for Terraform azure authentication for staging

terraform init -reconfigure -backend-config="resource_group_name=rg1" -backend-config="storage_account_name=strgstatefiledev" -backend-config="container_name=container1" -backend-config="key=stg.terraform.tfstate"

terraform apply -var-file=”terraformstg.tfvars” --auto-approve

terraform destroy -var-file=”terraformstg.tfvars” --auto-approve 

=====================================================================================================

export LOCATION="northeurope"
export RESOURCE_GROUP_NAME="rmt-rg-tfstate"
export STORAGE_ACCOUNT_NAME="rmtsttfstate"
export CONTAINER_NAME="tfstate"

# Create Resource Group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create Storage Account
az storage account create -n $STORAGE_ACCOUNT_NAME -g $RESOURCE_GROUP_NAME -l $LOCATION --sku Standard_LRS

# Create blob container
az storage container-rm create --storage-account $STORAGE_ACCOUNT_NAME --name $CONTAINER_NAME


# terraform install
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

terraform init \
    --backend-config=resource_group_name=$RESOURCE_GROUP_NAME \
    --backend-config=storage_account_name=$STORAGE_ACCOUNT_NAME \
    --backend-config=container_name=$CONTAINER_NAME \
    --backend-config=key="akslza/terraform.state"


terraform plan --var-file terraform.tfvars -out tfplan

terraform apply tfplan

terraform destroy --var-file=terraform.tfvars




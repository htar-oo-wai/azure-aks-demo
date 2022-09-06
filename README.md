# 1Provision AKS Cluster
I refered the repo from [Provision an AKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-aks-cluster), containing Terraform configuration files to provision an AKS cluster on Azure.

# Create Service Principle Account before terraform apply
az ad sp create-for-rbac --skip-assignment

# Create storage container to store TFstates
az storage container create -n tfstate --account-name <storage_account_name>  --account-key <storage_account_key>

# update tfvar file - from service princitple account id
edit ssh keys & region to use
# apply terraform code
terraform apply --auto-approve

# get credential & login
az aks get-credentials --resource-group htaroowai-demo-rg --name aks-cluster1

# Access Dashboard
az aks browse --resource-group htaroowai-demo-rg --name aks-cluster1

# Remark : please use objectID from ClI output below, don't use from Azure Console
az ad sp list --filter "displayName eq 'name-of-sp'"


#!/usr/bin/env bash

roleName="Contributor"
subscriptionID=$(az account show --query id -o tsv)


echo "Creating SP for RBAC with name $servicePrincipalName, with role $roleName and in scopes /subscriptions/$subscriptionID"
subscription="af2174da-9280-40ab-93b7-c5bab2b3c6e5"

read -d '' appId clientSecret tenantID <<< $(az ad sp create-for-rbac \
  --role $roleName \
  --scope "/subscriptions/$subscriptionID" \
  --query '[appId, password, tenant]' \
  -o tsv)

echo "Setting terraform variables"
export TF_VAR_azure_app_id="$appId"
export TF_VAR_azure_password="$clientSecret"
export TF_VAR_azure_subscription_id="$subscriptionID"
export TF_VAR_azure_tenant_id="$tenantID"

echo "Script finished"
#!/usr/bin/env bash

echo "Configuring state backend"
cd iac


echo "Run service principal creation"

. ./create_service_principal.sh

echo "Run terraform in directory"
cd tf

echo "terraform init"
terraform init

echo "terraform apply"
terraform apply -auto-approve

echo "terraform init for backend"
terraform init -force-copy
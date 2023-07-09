#!/usr/bin/env bash

set -xe

read 

# Initialize terraform
terraform init

# Terraform plan
terraform plan

# Terraform apply
terraform apply -y

# Update your kubeconfig to the newly created cluster

# Install the helm chart for the app

# Get the URL for the LB Service

# Provide the URL to the user for them to go to
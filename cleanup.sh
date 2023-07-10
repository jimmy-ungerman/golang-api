#!/bin/bash
set -eu

export AWS_PAGER=""

# Ensure we have AWS Creds
if aws sts get-caller-identity &> /dev/null; then
    user=$(aws sts get-caller-identity | jq -r '.Arn' )
    account=$(aws sts get-caller-identity | jq -r '.Account')
    echo "Cleaning up Golang API in AWS Account: $account using user: $user"
else
    echo "AWS credentials not found, running aws configure"
    aws configure
fi

# Uninstall the Application to remove the LB from AWS
if ! helm ls --all --short | xargs -L1 helm delete; then
    echo "Golang API is already destroyed"
fi

# Sleep to ensure LB is deleted
sleep 10

# Run Terraform Destroy to tear down cluster
cd infra
terraform destroy -auto-approve 
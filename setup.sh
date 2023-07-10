#!/bin/bash
set -eu

export AWS_PAGER=""
# Ensure we have AWS Creds
if aws sts get-caller-identity &> /dev/null; then
    user=$(aws sts get-caller-identity | jq -r '.Arn' )
    account=$(aws sts get-caller-identity | jq -r '.Account')
    echo "Setting up Golang API in AWS Account: $account using user: $user"
else
    echo "AWS credentials not found, running aws configure"
    aws configure
fi

## Run Terraform Commands
cd infra

# Init
if terraform init &> /dev/null; then
    echo "Initializing Terraform..."
else
    echo "Terraform Init failed...please try again"
    exit 1
fi

# Apply
terraform apply 

## Deploy Application

# Update Kubeconfig to the newly created Cluster
echo "Retrieving cluster Kubeconfig..."
aws eks update-kubeconfig --region us-east-1 --name golang-api-demo &> /dev/null

# Helm install the application
echo "Installing golang-api to cluster..."
cd ../charts/golang-api
helm upgrade --install golang-api . 

sleep 10
# Get the URL for the LB Service
URL=$(kubectl get services -n default golang-api --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Hit the LB Service until it's up
attempt_counter=0
max_attempts=20

until $(curl --output /dev/null --silent --head --fail $URL); do
    if [ ${attempt_counter} -eq ${max_attempts} ];then
    echo "LB failed"
    exit 1
    fi

    printf '.'
    attempt_counter=$(($attempt_counter+1))
    sleep 10
done

# Provide the URL for the user to go to

response=$(curl -s -w "%{http_code}" $URL)
http_code=$(tail -n1 <<< "$response")

if [[ "$http_code" == "200" ]]; then
    echo "API is running at $URL"
fi


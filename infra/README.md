# Golang API Infrastructure

Terraform code that builds the infra required to deploy the Golang-API

## Infrastructure Created

The following infrastructure is created to ensure that the API is able to run in EKS:

* EKS Cluster
* Managed Node Group of t3.small Spot Instances
* VPC
* 3 Public Subnets (In three availability zones)
* 3 Private Subnets (In three availabilty zones)
* NAT Gateway for Internet Connectivity in the private subnets

If running in your own environment, make sure to set the name of your s3 bucket on line 4 of `backend.tf` to store your terraform state
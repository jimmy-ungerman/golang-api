# Golang API 
A simple Golang REST API that responds with an Epoch timestamp and a string in JSON format.

## Prerequisites

To ensure that pipelines run successfully, the following prerequisites are required:
* Create an AWS Account
* Create your own IAM User with Admin priviliges
* Create an S3 Bucket to store your terraform state

## Automation

There are two ways to setup the full stack in this repo:
* Scripts
* Github Actions

### Scripts

A `setup.sh` and `cleanup.sh` script have been provided to give a one time command to setup and tear down the cluster as well as deploy the application. 

### Github Actions

The Github Actions located in `.github/workflows` is a set of pipelines written to introduce CI/CD to the environment.
 
`app-pipeline.yaml` contains all of the functionaility to test, build, scan, and deploy the Golang-API application.

`tf-apply.yaml` contains all of the functionaility to apply the terraform code to our cloud provider and keep it up to date as the terraform code changes. It works automatically with changes to the `infra` directory, but it can also be called manually to setup the infrastructure as you'd like.

`tf-destroy.yaml` contains a manual job that will allow you to destroy the environment through the Github UI.

# terraform-backend
A base setup to allow other projects to have S3-based terraform remote backends

## Context
Terraform is an infrastructure-as-code tool that uses the AWS CLI to manage AWS resources (such as buckets, DynamoDB tables, etc.). Terraform keeps information about what it has deployed in so-called _states_ and states them-selves are stored in _terraform backends_. Such backends can be local (on the machine where the terraform commands are executed) and also remote (and thus principally shared).

This repository setups an S3 bucket in AWS in order to store such terraform states for _other projects / services_ plus a DynamoDB table so that during deployment these states can be locked. It actually does this per configured environment in the `envs` folder.

> Please note that the state of resources created with this terraform code is not stored in AWS ("chicken-egg-problem"), but rather locally in `.tfstate`-files in the respective envs-folders and that these folders are checked into git (which is usually not a good practice for resources that change frequently)

## Prerequisites
1. In order to run terraform, you need to install it first. 
2. Also, you need to have an AWS CLI client installed along with credentials for the account the remote backend resources shall be created in.

## Configuration
These scripts create an S3 bucket (encrypted, with versioning) and a DynamoDb table for each environment. Switch between environments using the `STAGE` environment variable. 

## Creating remote-backend AWS resources
There is a `Makefile` in the root of this project. Use this to run the terraform commands:

```
export STAGE=THE_ENVIRONMENT_YOU_WANT_TO_DEPLOY
make apply-tf
```

_(The Makefile automatically initializes terraform (using `terraform init` ), default is `STAGE=development`)_

# Other repositories using the remote backend
Other repositories can now use the created S3 bucket as a remote backend. 

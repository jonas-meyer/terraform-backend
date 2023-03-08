variable "region" {
  description = "The AWS region"
  default     = "eu-west-2"
}

variable "stage" {
  type = string
}

variable "deployment_name" {
  type        = string
  description = "name prefix for resources"
}

variable "repo_name" {
  type        = string
  description = "git repository that manages the resources"
}

variable "common_tags" {
  type        = map(string)
  description = "common AWS resource tags"
  default     = {}
}


locals {
  resource_prefix = "${var.deployment_name}-${var.stage}"

  common_tags = merge(var.common_tags, {
    deployment  = var.deployment_name
    managedby   = var.repo_name
    Environment = var.stage
  })
}
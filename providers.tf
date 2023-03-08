terraform {
  required_version = "~> 1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.57.1"
    }
  }

  backend "local" {}
}

provider "aws" {
  region = var.region
  s3_use_path_style = true

  default_tags {
    tags = local.common_tags
  }

}

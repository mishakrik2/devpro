terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }

  required_version = ">= 0.14.9"
}

# Defined as env variables

provider "aws" {
    profile = "default"
    region = "${var.AWS_REGION}"
}

# Defined as env variables

provider "cloudflare" {
  #email = var.cloudflare_email
  #api_key = var.cloudflare_key
}
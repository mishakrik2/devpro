terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    acme = {
      source = "vancluever/acme"
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
}

provider "acme" {
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}
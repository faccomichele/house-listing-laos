terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  required_version = "~> 1.9"
}

provider "http" {}
# Configure the AWS Provider, it relies on the default profile configuration of your AWS CLI
provider "aws" {}
# Configure the DigitalOcean Provider
# Set the variable value as environment variables DIGITALOCEAN_ACCESS_TOKEN
provider "digitalocean" {}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.8.0"
    }
    
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

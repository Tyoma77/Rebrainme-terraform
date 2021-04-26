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

    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }

    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.40.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  backend "azurerm" {
    resource_group_name  = "corefunctions"
    storage_account_name = "corestorageus"
    container_name       = "terraform"
    key                  = "kube-hway.tfstate"
  }
}

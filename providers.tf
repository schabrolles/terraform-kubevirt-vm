terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  insecure    = "true"
  token       = var.ocpvirt_token != "" ? var.ocpvirt_token : null
  host        = var.ocpvirt_host != "" ? var.ocpvirt_host : null
  config_path = var.ocpvirt_token != "" && var.ocpvirt_host != "" ? null : "~/.kube/config"
  #   # config_path    = "~/.kube/config"
  #   # config_context = "default/api-ocpvirt-mop-ibm:6443/schabrolles"
}

provider "kubectl" {
  insecure         = "true"
  host             = var.ocpvirt_host != "" ? var.ocpvirt_host : null
  token            = var.ocpvirt_token != "" ? var.ocpvirt_token : null
  load_config_file = var.ocpvirt_token == "" && var.ocpvirt_host == "" ? "true" : "false"
  config_path      = var.ocpvirt_host != "" && var.ocpvirt_host != "" ? null : "~/.kube/config"
  # config_context = "default/api-ocpvirt-mop-ibm:6443/schabrolles"
}
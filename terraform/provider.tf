terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.98.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.provider_endpoint
  username = var.provider_username
  password = var.provider_password
  insecure = true
}

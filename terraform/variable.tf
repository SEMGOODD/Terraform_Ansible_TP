variable "app_vm_name" {
  type = string
}

variable "bdd_vm_name" {
  type = string
}

variable  "node_name"{
    type = string
}

variable "core" {
  type = number
}

variable "app_RAM" {
  type = number
}

variable "bdd_RAM" {
  type = number
}

variable "bridge" {
  type = string
}

variable "pool_id" {
    type = string
}

variable "key_name" {
  type = string
}

variable "file_permission" {
  type = string
}

variable "directory_permission" {
  type = string
}

variable "algorithm" {
  type = string
}

variable "rsa_bits" {
  type = number
}

variable "vm_count" {
  type = number
}

variable "app_vm_id" {
  type = number
}

variable "bdd_vm_id" {
  type = number
}

variable "datastore_id" {
  type = string
}

variable "interface" {
  type = string
}

variable "size" {
  type = number
}

variable "password" {
  type = string
}

variable "username" {
  type = string
}

variable "connection_type" {
  type = string
}

variable "user" {
  type = string
}

variable "fichier_source" {
  type = string
}

variable "fichier_destination" {
  type = string
}

variable "bdd_address" {
  type = string
}

variable "app_address" {
  type = string
}

variable "gateway" {
  type = string
}

variable "ssh_file" {
  type = string
}

variable "file_name" {
  type = string
}

variable "resource_pool_id" {
  type = string
}

variable "provider_endpoint" {
  type = string
}

variable "provider_username" {
  type = string 
}

variable "provider_password" {
  type = string
}

variable "iso_datastore_id" {
  type        = string
  description = "Le datastore où se trouvent les ISOs"
}

variable "content_type" {
  type = string
}

variable "yaml_file_name" {
  type = string
}
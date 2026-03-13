data "proxmox_virtual_environment_pool" "ressource_pool" {
  pool_id = var.pool_id
}

data "proxmox_virtual_environment_file" "ubuntu_iso" {
  node_name    = var.node_name
  datastore_id = var.iso_datastore_id
  content_type = "iso"
  file_name    = var.file_name
}

data "local_file" "ssh_public_key" {
    filename = pathexpand("${var.ssh_file}.pub")
}
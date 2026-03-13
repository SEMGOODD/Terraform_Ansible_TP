resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  vm_id = var.app_vm_id
  name = var.app_vm_name
  node_name = var.node_name
  pool_id = var.pool_id

  agent {
    enabled = true
  }
  
  cpu {
    cores = var.core
  }

  memory {
    dedicated = var.app_RAM
    floating  = var.app_RAM
  }

  network_device {
    bridge = var.bridge
  }

  disk {
    datastore_id = var.datastore_id
    interface = var.interface
    size = var.size
    file_id = var.iso_id
  }

  initialization {
    datastore_id = var.datastore_id

    ip_config {
      ipv4 {
        address = var.app_address
        gateway = var.gateway
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  provisioner "local-exec" {
    command = "echo 'IP machine ${var.app_vm_name}: ${var.app_address}' > ${var.app_vm_name}.ipv4.address"
  }
  
  connection {
    type = var.connection_type
    user = var.user
    private_key = file(var.ssh_file)
    host = split("/", var.app_address)[0]
  }

  provisioner "file" {
    source = var.fichier_source
    destination = var.fichier_destination
  }

  provisioner "remote-exec" {
    inline = [
      "cat ${var.fichier_destination}"
    ]
  }
}

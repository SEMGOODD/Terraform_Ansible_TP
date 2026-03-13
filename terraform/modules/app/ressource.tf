
resource "proxmox_virtual_environment_file" "cloud_config" { 
  content_type = var.content_type
  datastore_id = var.iso_datastore_id
  node_name    = var.node_name

  source_raw {
    file_name = var.yaml_file_name
    data = <<-EOF
    #cloud-config
    users:
      - default
      - name: ${var.username}
        groups: sudo
        shell: /bin/bash
        sudo: ALL=(ALL) NOPASSWD:ALL
        lock_passwd: false
        ssh_authorized_keys:
          - ${trimspace(var.ssh_public_key_content)}
    chpasswd:
      list:
        - ${var.username}:${var.password}
      expire: false
    packages:
      - qemu-guest-agent
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
    EOF

    }
}
module "vm_bdd" {
  source = "./modules/bdd"

  bdd_vm_name = var.bdd_vm_name
  node_name = var.node_name
  core = var.core
  bdd_RAM = var.bdd_RAM
  bridge = var.bridge
  bdd_vm_id = var.bdd_vm_id
  datastore_id = var.datastore_id
  interface = var.interface
  size = var.size
  connection_type = var.connection_type
  user = var.user
  fichier_source = var.fichier_source
  fichier_destination = var.fichier_destination
  bdd_address = var.bdd_address
  gateway = var.gateway
  ssh_file = var.ssh_file
  key_name = var.key_name
  file_permission = var.file_permission
  directory_permission = var.directory_permission
  algorithm = var.algorithm
  rsa_bits = var.rsa_bits
  app_vm_id = var.app_vm_id
  password = var.password
  username = var.username
  file_name = var.file_name
  resource_pool_id = var.resource_pool_id
  provider_endpoint = var.provider_endpoint
  provider_username = var.provider_username
  provider_password = var.provider_password
  iso_datastore_id = var.iso_datastore_id
  content_type = var.content_type
  yaml_file_name = var.yaml_file_name
  
  pool_id= data.proxmox_virtual_environment_pool.ressource_pool.id
  iso_id  = data.proxmox_virtual_environment_file.ubuntu_iso.id
  ssh_public_key_content = data.local_file.ssh_public_key.content
}

module "vm_app" {
  source = "./modules/app"

  app_vm_name = var.app_vm_name
  node_name = var.node_name
  core = var.core
  app_RAM = var.app_RAM
  bridge = var.bridge
  app_vm_id = var.app_vm_id
  datastore_id = var.datastore_id
  interface = var.interface
  size = var.size
  connection_type = var.connection_type
  user = var.user
  fichier_source = var.fichier_source
  fichier_destination = var.fichier_destination
  app_address = var.app_address
  gateway = var.gateway
  ssh_file = var.ssh_file
  key_name = var.key_name
  file_permission = var.file_permission
  directory_permission = var.directory_permission
  algorithm = var.algorithm
  rsa_bits = var.rsa_bits
  bdd_vm_id = var.bdd_vm_id
  password = var.password
  username = var.username
  file_name = var.file_name
  resource_pool_id = var.resource_pool_id
  provider_endpoint = var.provider_endpoint
  provider_username = var.provider_username
  provider_password = var.provider_password
  iso_datastore_id = var.iso_datastore_id
  content_type = var.content_type
  yaml_file_name = var.yaml_file_name

  pool_id = data.proxmox_virtual_environment_pool.ressource_pool.id
  iso_id  = data.proxmox_virtual_environment_file.ubuntu_iso.id
  ssh_public_key_content = data.local_file.ssh_public_key.content

  depends_on = [module.vm_bdd]
}

resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory.ini"

  content = <<-EOF
  [bdd]
  bdd_server ansible_host=${split("/", var.bdd_address)[0]}

  [app]
  app_server ansible_host=${split("/", var.app_address)[0]}

  [all:vars]
  ansible_user=ayoub
  ip_bdd=${split("/", var.bdd_address)[0]}
  ip_app=${split("/", var.app_address)[0]}
  ansible_ssh_private_key_file=${var.ssh_file}
  ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
EOF
}

resource "null_resource" "execute_ansible" {
  depends_on = [ local_file.ansible_inventory,
                 module.vm_bdd,
                 module.vm_app ]

  provisioner "local-exec" {
      # le sleep est pour être sûr que les VMs ont allumés avant de se connecter en SSH
      command = "sleep 10 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yml --vault-password-file ../ansible/vault_pass.txt"
    }
}

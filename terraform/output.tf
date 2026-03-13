output "app_vm_id" {
  description = "Id of the APP VM"
  value = module.vm_app.vm_id 
}


output "bdd_ip_bdd" {
  description = "Adresse IP de la machine BDD"
  value       = split("/", var.bdd_address)[0]
}

output "bdd_vm_id" {
  description = "Id of the BDD VM"
  value = module.vm_bdd.vm_id 
}

output "app_ip_app" {
  description = "Adresse IP de la machine APP"
  value       = split("/", var.app_address)[0]
}

output "ansible_user" {
  description = "Utilisateur SSH pour Ansible"
  value       = var.username
}

output "ansible_ssh_key" {
  description = "Clé privée utilisée par Ansible"
  value       = var.ssh_file
}

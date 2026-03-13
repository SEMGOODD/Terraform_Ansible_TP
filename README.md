# 🚀 Projet d'Automatisation - Terraform & Ansible

Ce projet automatise le déploiement d'une infrastructure complète sur Proxmox. Il déploie deux machines virtuelles (Ubuntu) :
- Une machine **Base de Données** (PostgreSQL)
- Une machine **Applicative** (FastAPI)

L'infrastructure est provisionnée avec **Terraform**, et la configuration des serveurs est gérée d'une manière automatisée par **Ansible** (avec Ansible Vault pour la gestion des secrets).

---

## 📋 Prérequis

Pour exécuter ce projet, vous devez avoir installé sur votre machine :
- [Terraform](https://www.terraform.io/downloads)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Une clé SSH valide (par défaut : `~/.ssh/id_terraform`). *Si vous n'en avez pas, générez-la avec `ssh-keygen -t rsa -f ~/.ssh/id_terraform`.*

---

## ⚙️ Configuration avant lancement

Pour des raisons de sécurité, les identifiants et mots de passe ne sont pas versionnés sur Git. Vous devez recréer deux fichiers locaux avant de lancer le déploiement.

### 1. Variables Terraform
Les variables spécifiques à votre environnement Proxmox doivent être définies. Un fichier d'exemple nommé ```bash terraform.tfvars.example``` est fourni.

Placez-vous dans le dossier `terraform`, copiez le fichier d'exemple et remplissez vos informations (IP Proxmox, identifiants, réseau cible et clé ssh) :
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars

```

### 2. Mot de passe Ansible Vault
Les identifiants de la base de données sont chiffrés dans ansible/vars/secrets.yml
Terraform a besoin du mot de passe pour qu'Ansible puisse déchiffrer ce fichier lors de l'exécution.


### 3. Déploiement
Une fois la configuration terminée, restez dans le dossier terraform et exécutez les commandes suivantes :

```bash
terraform init

terraform plan

terraform apply
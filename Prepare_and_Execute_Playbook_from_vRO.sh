#!/bin/bash

# Deploy a single role on a single target
# Call depuis le Controler Ansible: Prepare_and_Execute_Playbook_from_vRO   IPTarget  TargetRootPassword   Role


# Recuperation des variables
IPtarget=$1
targetRootPassword=$2
Role=$3
echo "IP target = $IPtarget"
echo "Target Root password = $targetRootPassword"
echo "Role = $Role"


#creation de variables
PlaybookFile=/etc/ansible/$IPtarget_playbook.yml
echo "PlaybookFile = $PlaybookFile"

# Copy de la clé publique sur le target
sshpass -p $targetRootPassword ssh-copy-id -o StrictHostKeyChecking=no root@$IPtarget


# Update du fichier /etc/ansible/hosts    :  Liste les hosts autorises
echo "$IPtarget" >> /etc/ansible/hosts


# Creation du playbook avec ajout du role
rm -f $PlaybookFile
touch $PlaybookFile
echo --- >> $PlaybookFile
echo "- hosts: all" >> $PlaybookFile
echo "  roles:" >> $PlaybookFile
echo "  - $Role" >> $PlaybookFile

ansible-playbook  -i "$IPtarget," $PlaybookFile



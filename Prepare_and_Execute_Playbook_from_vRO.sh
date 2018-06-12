#!/bin/bash

# Deploy a simple role on a single target
# Call depuis le Controler Ansible: Prepare_and_Execute_Playbook_from_vRO   IPTarget     Role


# Recuperation des variables
IPtarget=$1
Role=$2
echo "IP target = $IPtarget"
echo "Role = $Role"

PlaybookFile=/etc/ansible/$IPtarget_playbook.yml


# Copy de la clé publique sur le target
sshpass -p changeme ssh-copy-id -o StrictHostKeyChecking=no root@$IPtarget


# Update du fichier /etc/ansible/hosts    :  Liste les hosts autorisés
echo "$IPtarget" >> /etc/ansible/hosts


# Creation du playbook avec ajout du role
rm -f $PlaybookFile
touch $PlaybookFile
echo --- >> $PlaybookFile
echo "- hosts: all" >> $PlaybookFile
echo "  roles:" >> $PlaybookFile
echo "  - $Role" >> $PlaybookFile

ansible-playbook  -i "$IPtarget," $PlaybookFile



# script d'install Ansible on prem
# --------------------------------




yum install -y python-pip

yum install -y ansible


# vault config
mkdir /home/centos
touch /home/centos/.vault_pass.txt
echo  password > /home/centos/.vault_pass.txt
echo "vault_password_file = /home/centos/.vault_pass.txt" >> /etc/ansible/ansible.cfg


# disable SSH key host checking
echo "host_key_checking = False" >> /etc/ansible/ansible.cfg


# default user to use for playbooks if user is not specified
echo "remote_user = root" >> /etc/ansible/ansible.cfg



# Creation d'une paire de clé sans passphrase
ssh-keygen -f /root/.ssh/id_rsa -P ""

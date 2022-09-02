Installing ansible and dependencies:
(host: ansible)

```
dnf install python3 python3-pip -y
dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf install ansible -y
```

Copy SSH key of user: ansible to ansible server (ansible user was already created for Steveops):
(host: hpcgate)

```
cd /home/ansible/.ssh
ssh-copy-id ansible@ansible
```

Ansible searches for configuration files in the following order, processing the first file it finds and ignoring the rest:

```
$ANSIBLE_CONFIG if the environment variable is set.
ansible.cfg if it’s in the current directory.
~/.ansible.cfg if it’s in the user’s home directory.
/etc/ansible/ansible.cfg, the default config file.
```

The default inventory file is found inside /etc/ansible/hosts, but this location can be changed in the configuration file. You can also specify which inventory file to use with the -i switch.

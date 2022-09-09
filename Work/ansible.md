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
(host: ansible)

```
$ANSIBLE_CONFIG if the environment variable is set.
ansible.cfg if it’s in the current directory.
~/.ansible.cfg if it’s in the user’s home directory.
/etc/ansible/ansible.cfg, the default config file.
```

 Inventory basics: formats, hosts, and groups:

The system-level default host file is found at '/etc/ansible/hosts', but this location can be changed in the configuration file. You can also specify which inventory file to use with the -i flag.
Ansible can be instructed to select All or only Portions of your inventory. 

The two default groups are 'All' and 'Ungrouped'. All contains every host, while ungrouped contains all hosts that don't have another group aside from all. Every host will always belong to at least two groups.




The inventory file can be in one of many formats, depending on the inventory plugins you have. The most common formats are INI and YAML. 

INI format default output of /etc/ansible/hosts:
```
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com
```




YAML format default output of yaml_hosts file:
```
all:
  hosts:
    mail.example.com:
  children:
    webservers:
      hosts:
        foo.example.com:
        bar.example.com:
    dbservers:
      hosts:
        one.example.com:
        two.example.com:
        three.example.com:
```




Playbooks:

Playbooks can be used to set up, configure, and manage complex environments and they can be used to do this in the cloud, in VM, or bare metal. Playbooks can be used to perform simple configuration management, as well manage complex task. 

Each Playbook is a script composed of one or more plays. Each play subsequently executes one or more tasks, which essentially are calls to Ansible modules. Modules perform action like configuration changes, patches, fixes, and so on.




All Playbooks are saved at /mops/admin/ansiblePlaybook directory. All yaml file starts with three dash lines (---), equivalent to bash script #!/bin/bash, and end with three periods (...). You should always run the Playbook as ansible user.

example of a Playbook yml file:
```
---
- hosts: all
  tasks:
    - name: Print message
      debug:
        msg: Hello Ansible World
...
```



To run the example Playbook, first login as ansible user and 'cd /mops/admin/ansiblePlaybook' where the 'HelloWorld.yml' Playbook is located. Even if you are login as root user and using the '-u ansible' flag results in Playbook error.
```
cd /mops/admin/ansiblePlaybook/
ansible-playbook HelloWorld.yml -u ansible
```

Output:
```
PLAY [all] *******************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [aixl675dn01]
ok: [aixl675dn06]
ok: [aixl675dn02]
ok: [aixl675dn04]
fatal: [aixl675dn03]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: ssh: connect to host aixl675dn03 port 22: No route to host", "unreachable": true}
ok: [aixl645dn02]
ok: [aixl645dn01]
ok: [aixl675dn08]
ok: [aixl645dn04]
ok: [aixl675dn07]
ok: [aixl645dn06]

TASK [Print message] *********************************************************************************************
ok: [aixl675dn01] => {
    "msg": "Hello Ansible World"
}
ok: [aixl675dn02] => {
    "msg": "Hello Ansible World"
}
ok: [aixl675dn04] => {
    "msg": "Hello Ansible World"
}
ok: [aixl675dn06] => {
    "msg": "Hello Ansible World"
}
ok: [aixl675dn07] => {
    "msg": "Hello Ansible World"
}
ok: [aixl675dn08] => {
    "msg": "Hello Ansible World"
}
ok: [aixl645dn01] => {
    "msg": "Hello Ansible World"
}
ok: [aixl645dn02] => {
    "msg": "Hello Ansible World"
}
ok: [aixl645dn04] => {
    "msg": "Hello Ansible World"
}
ok: [aixl645dn06] => {
    "msg": "Hello Ansible World"
}

PLAY RECAP *******************************************************************************************************
aixl645dn01                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
aixl645dn02                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
aixl645dn04                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
aixl645dn06                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
aixl675dn01                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
aixl675dn02                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
aixl675dn03                : ok=0    changed=0    unreachable=1    failed=0    skipped=0    rescued=0    ignored=0
aixl675dn04                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
aixl675dn06                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
aixl675dn07                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
aixl675dn08                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```





Variables:

Under the hosts line in a Playbook you can specify some variables using 'vars' as seen below:
```
---
- hosts: all
  vars:
	# used for filepaths on the server
	website_name: "mynginx"
	# this variable is referenced in website conf file
	website_url: "www.mygnix.local"
...
```



Not all modules work with all operating systems and if we want to make a Playbook more universal, we can append some settings where some tasks will test the Ansible facts on the remote host. This helps reduce the number of Playbook scripts by creating scripts that are adaptive and they're adaptive to the systems that they're being executed on.

For the follow example below; the Playbook task is to install python development package on two different OS system, the package name are different on different OS system.
```
---
- hosts: tusken
  gather_facts: true
  name: install python development package on RHEL and Ubuntu hosts
  tasks:
	-name: install python development package on Ubuntu
 	# debug: var=ansible_facts 
 	apt:
		name: python-dev
	when: ansible_faces['distribution'] == "Ubuntu"
	
	-name: install python development package on RHEL
	# debug: var=ansible_facts
	yum:
		name: python-devel
	when: ansible_faces['distribution'] == "RHEL"
...
```



Loop function:

In this example for this Playbook, we use a loop function to create 3 users for all tusken node.
```
---
- hosts: tusken
  gather_facts: true
  name: add users to all tusken machine
  tasks:
	-name: add user
 	user:
		name: "{{ item }}"
		state: present
		groups: "hpcd"
	loop:
		- voth
		- thaiv
		- tvo
...	
```

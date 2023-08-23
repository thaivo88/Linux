sudo superuser do
apt-get is an installer
```
  sudo apt-get update
  sudo apt-get dist-upgrade
```
installing open ssh
```
  sudo apt-get install openssh-server
  sudo reboot
```
ufw is the syntax for Uncomplicated Firewall to allow different port to be enable; using the protocol name or port number
```  
  sudo ufw allow http
  sudo ufw allow 80
  sudo ufw allow https
  sudo ufw allow 443
  sudo ufw allow ssh
  sudo ufw allow 22
  sudo ufw allow 10000
  sudo ufw allow 25
  sudo ufw allow 110
```
```
  sudo apt-get update
  sudo apt-get install apache2
  sudo apache2ctl configtest
```

block IP address
```  sudo ufw deny from [xx.xx.xx.xx]```

Block Connections to a Network Interface
```  sudo ufw deny in on eth0 from [xx.xx.xx.xx]```

allow Incoming SSH from Specific IP Address or Subnet
For example, if you want to allow the entire 15.15.15.0/24 subnet, run this command:
```  sudo ufw allow from 15.15.15.0/24  to any port 22```

allow all incoming HTTP and HTTPS (port 443) connections
```  sudo ufw allow proto tcp from any to any port 80,443```


# ip address ubuntu >18 
/etc/netplan is the “new” place to set network settings
commented out the entry for ib0 in /etc/network/interfaces
Added  the following to /etc/netplan/50-cloud-init.yaml
```       
network:
    ethernets:
        eno1:
            addresses:
            - 10.100.0.34/16
            dhcp4: false
            gateway4: 10.100.0.5
            nameservers:
                addresses:
                - 15.x.x.x
                - 16.x.x.x
                search: []
        eno2:
            addresses: []
            dhcp4: true
            optional: true
        eno3:
            addresses: []
            dhcp4: true
            optional: true
        eno4:
            addresses: []
            dhcp4: true
            optional: true
        ib0:
            addresses:
            - 192.168.0.34/16
    version: 2
```            
testing and apply the config
```
        netplan try
        netplan apply
```




hostname setup
```
        hostnamectl set-hostname [hostname]
        nano /etc/cloud/cloud.cfg
```
Search for preserve_hostname and change the value from false to true:
```
preserve_hostname: true
```





# Disable auto update
0 disable
1 enable
```
sed -i 's/APT::Periodic::Update-Package-Lists "1";/APT::Periodic::Update-Package-Lists "0";/' /etc/apt/apt.conf.d/20auto-upgrades
sed -i 's/APT::Periodic::Unattended-Upgrade "1";/ APT::Periodic::Unattended-Upgrade "0";/' /etc/apt/apt.conf.d/20auto-upgrades 
```   

# disable kernel update 
by pining down the kernel as the kernel still update when using apt update command.
```
echo linux-image-4.15.0-99-generic hold | dpkg --set-selections
apt-mark hold linux-image-4.15.0-99-generic
```

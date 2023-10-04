```
//connect to ilo cli
ssh [ilo_ip_address] -l [username]
exampe: ssh 10.100.1.148 -l admin

//to reset ilo
cd /map1
reset

//to show LED status
show /system1/led1

//to start the LED
start /system1/led1

//to view the firmware of the ilo
show /map1/firmware1

//show the list of users
show /map1/accounts1

//changing password of a user
set /map1/accounts1/[username] password=[password]

//create user
create /map1/accounts1 username=[username] password=[password]

//to view the assigned network of the blade
show /map1/enetport1/lanendpt1/ipendpt1

//to assign mamagement IP to the blade ilo passge
set /map1/enetport1/lanedpt1/ipendpt1 IPv4Address=[xx.xx.xx.xx] SubnetMask=[xx.xx.xx.xx]

//change or modify the gateway of the management ip
set /map1/gateway1 AccessInfo=[xx.xx.xx.xx]

//add DNS server
set /map1/dnsserver1 AccessInfo=[xx.xx.xx.xx]

//to vew the DHCP status of ilo
show /map1/dhcpendpt1

//enable or disable DHCP
set /map1/dhcpendpt1 EnableState=[no|off]

//show SNMP
show /map1/snmp1

//to configure SNMP
set /map1/snmp1 accessinfo=[xx.xx.xx.xx]

//set system location
set /map1/snmp1/ oemhp_systemlocation="[location]"

//set name of node
set /map1/enetport1 systemname=[servername]

//view boot order
show /system1/bootconfig1

//view boot order of all available boot source
show -all /system1/bootconfig1

//change boot order
set /system1/bootconfig1/[bootsource#] [bootsource#]
example: set /system1/bootconfig1/bootsource3 bootsource1

//view CPU info
show /system1/[cpu#] 
example: show /system1/cpu2
```



Work around**
Mounting ISO with hpilo cli
mounting a URL for an ISO file

```bash
</map1/oemHPE_vm1/cddr1>hpiLO-> set /map1/oemhp_vm1/cddr1 oemhp_image=http://dist.milp.rdlabs.hpecorp.net/test/stout726///latest-rhel86-x86_64/ISO/cm-admin-install-1.8-rhel86-x86_64.iso

status=0
status_tag=COMMAND COMPLETED
Wed Oct  4 14:34:50 2023
```

show the status of virtual cd if the url mount was successful

```bash
</map1/oemHPE_vm1/cddr1>hpiLO-> show /map1/oemhp_vm1/cddr1                                                        
status=0
status_tag=COMMAND COMPLETED
Wed Oct  4 14:34:59 2023

/map1/oemHPE_vm1/cddr1
  Targets
  Properties
    oemHPE_image=http://dist.milp.rdlabs.hpecorp.net/test/stout726///latest-rhel86-x86_64/ISO/cm-admin-install-1.8-rhel86-x86_64.iso
    oemHPE_connect=No
    oemHPE_boot=No_Boot
    oemHPE_wp=Yes
    vm_applet=No
  Verbs
    cd version exit show set
```

booting once to virtual cd

```bash
</map1/oemHPE_vm1/cddr1>hpiLO-> set /map1/oemhp_vm1/cddr1 oemhp_boot=Once

status=0
status_tag=COMMAND COMPLETED
Wed Oct  4 14:42:57 2023
```

Show boot status of boot order 1

```bash
</map1/oemHPE_vm1/cddr1>hpiLO-> show /system1/bootconfig1/oemHPE_uefibootsource1

status=0
status_tag=COMMAND COMPLETED
Wed Oct  4 14:45:32 2023

/system1/bootconfig1/oemHPE_uefibootsource1
  Targets
  Properties
    bootorder=1
    oemHPE_description=iLO Virtual USB 3 : iLO Virtual CD-ROM
  Verbs
    cd version exit show set
```



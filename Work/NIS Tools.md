NIS Tools
To work better with the Linux NIS server, there are some useful tools that can help you manage the information in the database.

ypcat: This tool is used to get data from the NIS server by extracting it from NIS map.

ypwhich: gets the name of the Linux NIS server that is responding to your requests.

ypmatch: rather than grabbing the entire map, or you can search by key to get a specific entry.

if NIS fail to let user access run:
```
authselect select nis --force
```

start ypbind during boot
```
chkconfig ypbind on
```
Note: Forwarding request to 'systemctl enable ypbind.service'.




you can check a list of all the NIS map by doing a 
```
ypcat -x
```
output
```
Use "ethers"    for map "ethers.byname"
Use "aliases"   for map "mail.aliases"
Use "services"  for map "services.byname"
Use "protocols" for map "protocols.bynumber"
Use "hosts"     for map "hosts.byname"
Use "networks"  for map "networks.byaddr"
Use "group"     for map "group.byname"
Use "passwd"    for map "passwd.byname"
```
you can issue ypcat hosts to see the mapping of all the host list of /etc/hosts on hpcgate to the compute nodes running NIS.


configuration file located at /etc/nsswitch

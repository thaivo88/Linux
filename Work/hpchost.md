# Startup

Mount NFS Filesystems
```
mount /admin
mount /hpcsw
mount /usr1
mount /usr2
mount /usr3
mount /usr4
mount /usr5
mount /usr6
```
start daemons
```
  service postfix start
  service nfsserver start
  service ypserv start
  service ypbind start
  service yppasswdd start
  service smb start
  service omni start
  service mysql start
  service svnserve start
  service apache2 start
```  
kill martians
```
  cd /admin/scripts; ./kill-martians
```  

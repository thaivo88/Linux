When hpcgate reboot or startup run the following:
```
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
systemctl stop dhcpd.service
systemctl restart nfs
systemctl restart ypserv.service
mount -a
```

---

if NFS failed to start and the following error is below:
```
systemd[1]:Found ordering cycle on nfs-server.service/start
systemd[1]:Found dependency on apps-FileServer.mount/start
```

Do the following:
remove the partition mount points for NFS
```
cp /etc/fstab /etc/fstab.back
vi /etc/fstab
```
comment out each partitions
```
vi /etc/export
```
restart daemon
```
systemctl daemon-reload
systemctl start nfs-server
```
Then uncomment out each partitions for /etc/export
```
systemctl restart nfs-server
cp /etc/fstab.back /etc/fstab
```

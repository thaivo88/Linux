When hpcgate reboot or startup run the following:
```
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
systemctl status dhcpd.service
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
```
cp /etc/fstab /etc/fstab.back
vi /etc/fstab
```
remove the partition mount points for NFS
```
vi /etc/export
```
comment out each partitions
```
systemctl daemon-reload
systemctl start nfs-server
```
Then uncomment out each partitions for /etc/export
```
systemctl restart nfs-server
cp /etc/fstab.back /etc/fstab
```

How to remove a service that keeps the system from booting?
You can easily block a service from being started by adding a parameter to the kernel command line:
choice the OS and hit esc to get to GRUB.

```
systemd.mask=name.service
```


you can boot directly into a shell with 

```
init=/bin/sh
```

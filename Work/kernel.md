# Ubuntu

hold kernel version
```
apt-mark hold linux-image-[verison]-generic
apt-mark hold $(uname -r)
```

if kernel fail to load after installation
https://www.dedoimedo.com/computers/ubuntu-initrd-bug.html


check the current kernel version
```
uname -a
# output
Linux ainode08 4.15.0-55-generic #60-Ubuntu SMP Tue Jul 2 18:22:20 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
```  
  
  
check what kernel version are currently installed
```
dpkg --list | grep linux-image
  
# output:
  root@znode47:~# dpkg --list | grep linux-image
  rc  linux-image-4.15.0-29-generic                      4.15.0-29.31                                 amd64        Signed kernel image generic
  rc  linux-image-4.15.0-45-generic                      4.15.0-45.48                                 amd64        Signed kernel image generic
  rc  linux-image-4.15.0-46-generic                      4.15.0-46.49                                 amd64        Signed kernel image generic
  rc  linux-image-4.15.0-47-generic                      4.15.0-47.50                                 amd64        Signed kernel image generic
  rc  linux-image-4.15.0-55-generic                      4.15.0-55.60                                 amd64        Signed kernel image generic
  rc  linux-image-4.15.0-58-generic                      4.15.0-58.64                                 amd64        Signed kernel image generic
  rc  linux-image-4.15.0-60-generic                      4.15.0-60.67                                 amd64        Signed kernel image generic
  rc  linux-image-4.15.0-62-generic                      4.15.0-62.69                                 amd64        Signed kernel image generic
  ii  linux-image-4.15.0-64-generic                      4.15.0-64.73                                 amd64        Signed kernel image generic
  ii  linux-image-4.15.0-65-generic                      4.15.0-65.74                                 amd64        Signed kernel image generic
  ii  linux-image-generic                                4.15.0.65.67                                 amd64        Generic Linux kernel image
```


edit grub file to allow boot option for kernel during POST
```
vi /etc/default/grub
# edit lines below
  	GRUB_DEFAULT=0
	#GRUB_TIMEOUT_STYLE=hidden
	GRUB_TIMEOUT=10
```    

install the kernel image and headers
```
apt-get install linux-image-4.15.0-65-generic linux-headers-4.15.0-65-generic
```

update initramfs and grub to initialize the new kernel
```
update-initramfs -u
update-grub
reboot
```
  
After a reboot and the kernel fail to load and you see this error below:
```
Gave up waiting for root file system device. Common problems:
  -Boot args (cat /proc/cmdline)
    -Check rootdelay= (did the system wait long enough?)
  -Missing modules (cat /proc/modules; ls /dev)
  ALERT! UUID=135212h5kjh3o4htwoehgu3h4ugh34 does not exist. Dropping to a shell!
```

find another system with the new kernel that you just installed and copy over the initrd.img-4.15.0-65-generic
```
cd /boot
scp initrd.img-4.15.0-65-generic \root@znode44:/boot
```




# RHEL

To find and list the available kernel
```
dnf list | grep kernel
dnf list installed | grep kernel	# to list what is installed
```

If you installed a older version kernel to downgrade run the following command to take affect (Previous Minor Release):
```
yum downgrade redhat-release
```

To stop the kernel from being updated:
```
echo "exclude=kernel*" >> /etc/dnf/dnf.conf
# or
dnf update --exclude=kernel*
```

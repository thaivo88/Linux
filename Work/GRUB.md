choice the OS and hit 'esc' to get to GRUB boot option.
Hit 'e' to edit the Grub boot and 'Ctrl + x' to save and boot


How to remove a service that keeps the system from booting?
You can easily block a service from being started by adding a parameter to the kernel command line:
```
systemd.mask=name.service
```


you can boot directly into a shell with 

```
init=/bin/sh
```


If ISO load but screen is blacked out try the following before booting into text mode
```
nomodeset xdriver=vesa brokenmodules=ast 
```


Boot into text mode

```
nomodeset text
```


nvme_load=Yes 

pci=realloc=off



Below are steps on how to locate the bad NVMe drive:
For example, we need to locate /dev/nvme7n1
Locating drive PCI slot and drive details:

Show output of all nvme drives

```
ls -1 /dev/nvme* 
```

How to find the bus id of the drive

```
find /sys/devices|egrep ‘nvme7n1?$’
```

output:

```
/sys/devices/pci0000:36/0000:36:03.0/0000:3a:00.0/nvme/nvme7/nvme7n1
```

Query drive details (in this case I only wanted the SN/WWN)

```
lspci –s 12:00.0 –v|grep ‘Serial Number’
```

output:

```
Capabilities: [270] Device Serial Number 55-cd-2e-41-4f-6f-a3-aa
```

Powering On/Off drive:

Get the bus id of the drive
#find /sys/devices|egrep ‘nvme7n1?$’
/sys/devices/pci0000:36/0000:36:03.0/0000:3a:00.0/nvme/nvme7/nvme7n1
Locating slot #
#grep '3a' /sys/bus/pci/slots/*/address
/sys/bus/pci/slots/8/address:0000:3a:00
Powering down slot
#echo 0 > /sys/bus/pci/slots/8/power
Powering on slot
#echo 1 > /sys/bus/pci/slots/8/power

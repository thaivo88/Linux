Below are steps on how to locate the bad NVMe drive:
For example, we need to locate /dev/nvme0n1
Locating drive PCI slot and drive details:

Show output of all nvme drives

```
ls -1 /dev/nvme* 
```

How to find the bus id of the drive

```
find /sys/devices|egrep 'nvme0n1?$'
```

output:

```
/sys/devices/pci0000:40/0000:40:01.1/0000:43:00.0/0000:44:03.0/0000:4d:00.0/nvme/nvme0/nvme0n1
```

Query drive details (in this case I only wanted the SN/WWN)

```
lspci -s 4d:00.0 -v|grep -i Serial
```

output:

```
 Capabilities: [148] Device Serial Number 66-b7-00-11-94-38-25-00
```




# Powering On/Off drive: #

Get the bus id of the drive

```
find /sys/devices|egrep 'nvme0n1?$'
```

Output:

```
/sys/devices/pci0000:40/0000:40:01.1/0000:43:00.0/0000:44:03.0/0000:4d:00.0/nvme/nvme0/nvme0n1
``

Locating slot #

```
grep '3a' /sys/bus/pci/slots/*/address
```

output:

```
/sys/bus/pci/slots/8/address:0000:3a:00
```

Powering down slot

```
echo 0 > /sys/bus/pci/slots/8/power
```

Powering on slot

```
echo 1 > /sys/bus/pci/slots/8/power
```

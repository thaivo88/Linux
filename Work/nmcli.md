#nmcli - command line tool for controlling NetworkManager#


Static IP Address using nmtui utility

```
nmtui
```

To get interface name attached to your systems:

```
nmcli device
```

Output:

```
DEVICE  TYPE      STATE      CONNECTION
enp0s3  ethernet  connected  enp0s3
lo      loopback  unmanaged  --
```

To view current connection:

```
nmcli connection show
```

Output:

```
NAME    UUID                                  TYPE      DEVICE
enp0s3  25d9c990-7b03-31bf-873b-489740d6e561  ethernet  enp0s3
```

Setting up static IP

```
nmcli con modify 'enp0s3' ifname enp0s3 ipv4.method manual ipv4.addresses 192.168.1.181/24 gw4 192.168.1.1
nmcli con modify 'enp0s3' ipv4.dns 4.2.2.2
nmcli con down 'enp0s3'
nmcli con up 'enp0s3'
```

PCI Access Control Services (ACS)

IO virtualization (also known as, VT-d or IOMMU) can interfere with GPU Direct by redirecting all PCI point-to-point traffic to the CPU root complex, causing a significant performance reduction or even a hang. You can check whether ACS is enabled on PCI bridges by running:

```
sudo lspci -vvv | grep ACSCtl
```

If lines show “SrcValid+”, then ACS might be enabled. Looking at the full output of lspci, one can check if a PCI bridge has ACS enabled.

```
sudo lspci -vvv
```

If PCI switches have ACS enabled, it needs to be disabled. On some systems this can be done from the BIOS by disabling IO virtualization or VT-d. For Broadcom PLX devices, it can be done from the OS but needs to be done again after each reboot.

Use the command below to find the PCI bus IDs of PLX PCI bridges:
(PCI bridge is better then PLX)

```
sudo lspci | grep PLX
lspci | grep -i "PCI bridge"
```

Next, use setpci to disable ACS with the command below, replacing 03:00.0 by the PCI bus ID of each PCI bridge.

```
sudo setpci -s 03:00.0 f2a.w=0000
```
 

I am seeing SrcValid+ when running the command above. And inspecting the output of lspci -vvvv shows that at

least two PCI bridges on, in one case, aixl675dn02 has this set:

00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])

```
    Capabilities: [2a0 v1] Access Control Services

        ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+

        ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
```

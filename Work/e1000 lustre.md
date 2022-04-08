## Plab E1000 Lustre 

# Shut down process:

Log in to the primary MGMT node via SSH: 
```
ssh into management node aiholus1n00
ssh aiholus1n00 -l admin
```

Change to root user: 
```
sudo su – 
```

Stop the Lustre file system: 
```
cscli unmount -f filesystem_name 
cscli unmount -f aiholus1
```

Verify that resources have been stopped by running the following on all even-numbered nodes: 
aiholusln02-6
```
cscli show_nodes
ssh aiholus1n02 crm_mon -r1 | grep fsys
```

Log in to the MGS node via SSH: 
```
ssh aiholus1n02
```

To check the MGS/MDS nodes to determine whether Resource Group md65-group is stopped, use the crm_mon utility to monitor the status of the MGS and MDS nodes and check that their resources have stopped: 
```
crm_mon -1r | grep fsys
```

If the node is not stopped, issue the stop_xyraid command:
```
stop_xyraid nodename_md65-group
```

log in to the MGMT node
```
ssh aiholus1n00
```

Power off the diskless nodes:
```
cscli power_manage -n aiholus1n[02-07] --power-off
```

Check the power-off status of the diskless nodes: (disskless nodes aiholus1n[02-07])
```
crm_mon -1r
pm -q aiholus1n[02-07]
```

From the primary MGMT node, power off the MGMT nodes: 
```
cscli power_manage -n aiholus1n[00-01] --power-off
```

or use 'pm' command if cscli failed to power off nodes
```
pm -0 aiholus1n0[0-1]
```

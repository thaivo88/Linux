Applying BIOS settings on servers
Procedure
To apply the BIOS settings on the servers, follow any one of the following substeps:

To apply the BIOS settings on all servers, run the following command:
```
nps deploy -s hw_prep -l debug -sl all -a bios
```

To apply the BIOS settings on a single server, run the following command:
```
nps deploy -s hw_prep -l debug -sl "<Server iLO IP>" -a bios
```

To apply the BIOS settings on a list of servers, run the following command:
```
nps deploy -s hw_prep -l debug -sl "<Server iLO IP1>,<Server iLO IP2>,<Server iLO IP3>" -a bios
```

To verify the status of the hardware preparation service, run the following command:
```
nps show --service hw_prep
```

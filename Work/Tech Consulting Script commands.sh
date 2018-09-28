pdsh –w node[x-xx] hponcfg –f /root/bin/bin/smartscript/Shared_Network_Port.xml
#     pdsh: parallel device sharing | hponcfg: HPE Lights-Out Online Configuration Utility
#     directory location: /root/bin/bin/smartscript/ file: Shared_Network_Port.xml
#     the file: Shared_Network_Port.xml is excuted by hponcfg then rolled out to node x-xx with pdsh -w node[x-xx]; 
#     this file disable all shared port (ilo sharing NIC1 port)

chmod 754 *
#     chmod: change mode
#     4 stands for "read",
#     2 stands for "write",
#     1 stands for "execute", and
#     0 stands for "no permission."
#    
#     the user can read, write, and execute it;
#     members of your group can read and execute it; 
#     and others may only read it.
#     using above number 754
#     7 = (4: read) + (2: write) + (1: execute)
#     5 = (4: read) + (1: execute)
#     4 = (4: read)

conrep –s –f /root/xxxx.dat
#     The CONREP utility reads the state of the system environment settings to determine the server configuration and writes the results to a file that you can edit. 
#     The CONREP utility uses the data in the generated file to configure the target server hardware.
#     conrep: read server configuration and -s: save the -f: file to directoy: /root/ file name: xxxx.dat or xxxx.xml

Pdsh –w –node[x-xx] conrep –l –f /root/bin/Ford_tools/static_high.xml 
#     pdsh: parallel device share with nodes x-xx conrep: system config scan -l: load -f: file at directory /root/bin/Ford_tools/ file: static_high.xml

tail -f /var/log/messages
#     tail: show you the last 10 lines of a document
#     -f: follows; output follows are file grows

pdsh -w node[x-xx] ssacli ctrl all show config |grep logical| dshbak -c
#     |grep logical|: grep search for logical key word
#     ssacli is a controller utility: asking it to show all the configuration of all nodes from x-xx 
#     and roll out the command to all the nodes x-xx with pdsh

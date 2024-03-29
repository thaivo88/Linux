List Rules
```  iptables -L```


Saving Rules
Iptables rules are ephemeral, which means they need to be manually saved for them to persist after a reboot.
On Ubuntu, the easiest way to save iptables rules, so they will survive a reboot, is to use the iptables-persistent package. 
Install it with apt-get like this:
```  sudo apt-get install iptables-persistent```


During the installation, you will asked if you want to save your current firewall rules.
If you update your firewall rules and want to save the changes, run this command:
```  sudo netfilter-persistent save```


On versions of Ubuntu prior to 16.04, run this command instead:
```  sudo invoke-rc.d iptables-persistent save```

save iptables rules: 
```  dpkg-reconfigure iptables-persistent```

CentOS 6 and Older
On CentOS 6 and older—CentOS 7 uses FirewallD by default—you can use the iptables init script to save your iptables rules:
```  sudo service iptables save```
  
blocking all ports beside port 80 for webservice on eno2  
```
		iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
		iptables -A INPUT -i eno2 -p tcp --destination-port 80 -j ACCEPT
		iptables -A INPUT -i eno2 -j DROP
```
  
Allow Established and Related Incoming Connections
As network traffic generally needs to be two-way—incoming and outgoing—to work properly, it is typical to create a firewall rule 
that allows established and related incoming traffic, so that the server will allow return traffic to outgoing connections initiated 
by the server itself. This command will allow that:
```  sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT```


Allow Established Outgoing Connections
You may want to allow outgoing traffic of all established connections, which are typically the response to legitimate incoming 
connections. This command will allow that:
```  sudo iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT```


Internal to External
Assuming eth0 is your external network, and eth1 is your internal network, this will allow your internal to access the external:
```  sudo iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT```


Drop Invalid Packets
Some network traffic packets get marked as invalid. Sometimes it can be useful to log this type of packet but often it is fine to 
drop them. Do so with this command:
```  sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP```


Block an IP Address
To block network connections that originate from a specific IP address, 15.15.15.51 for example, run this command:
```  sudo iptables -A INPUT -s 15.15.15.51 -j DROP```
In this example, -s 15.15.15.51 specifies a source IP address of "15.15.15.51". The source IP address can be specified in any firewall 
rule, including an allow rule.


If you want to reject the connection instead, which will respond to the connection request with a "connection refused" error, 
replace "DROP" with "REJECT" like this:
```  sudo iptables -A INPUT -s 15.15.15.51 -j REJECT```


Block Connections to a Network Interface
To block connections from a specific IP address, e.g. 15.15.15.51, to a specific network interface, e.g. eth0, use this command:
```  iptables -A INPUT -i eth0 -s 15.15.15.51 -j DROP```
This is the same as the previous example, with the addition of -i eth0. The network interface can be specified in any firewall rule, 
and is a great way to limit the rule to a particular network.


Service: SSH
If you're using a cloud server, you will probably want to allow incoming SSH connections (port 22) so you can connect to and manage 
your server. This section covers how to configure your firewall with various SSH-related rules.
Allow All Incoming SSH
To allow all incoming SSH connections run these commands:
```
  sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
The second command, which allows the outgoing traffic of established SSH connections, is only necessary if the OUTPUT policy is not 
set to ACCEPT.


Allow Incoming SSH from Specific IP address or subnet
To allow incoming SSH connections from a specific IP address or subnet, specify the source. For example, if you want to allow the 
entire 15.15.15.0/24 subnet, run these commands:
```
  sudo iptables -A INPUT -p tcp -s 15.15.15.0/24 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
The second command, which allows the outgoing traffic of established SSH connections, is only necessary if the OUTPUT policy is not 
set to ACCEPT.


Allow Outgoing SSH
If your firewall OUTPUT policy is not set to ACCEPT, and you want to allow outgoing SSH connections—your server initiating an SSH 
connection to another server—you can run these commands:
```
  sudo iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
Allow Incoming Rsync from Specific IP Address or Subnet
Rsync, which runs on port 873, can be used to transfer files from one computer to another.


To allow incoming rsync connections from a specific IP address or subnet, specify the source IP address and the destination port. 
For example, if you want to allow the entire 15.15.15.0/24 subnet to be able to rsync to your server, run these commands:
```
  sudo iptables -A INPUT -p tcp -s 15.15.15.0/24 --dport 873 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A OUTPUT -p tcp --sport 873 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
The second command, which allows the outgoing traffic of established rsync connections, is only necessary if the OUTPUT policy is not 
set to ACCEPT.


Service: Web Server
Web servers, such as Apache and Nginx, typically listen for requests on port 80 and 443 for HTTP and HTTPS connections, respectively. 
If your default policy for incoming traffic is set to drop or deny, you will want to create rules that will allow your server to respond
to those requests.
Allow All Incoming HTTP
To allow all incoming HTTP (port 80) connections run these commands:
```
  sudo iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A OUTPUT -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
The second command, which allows the outgoing traffic of established HTTP connections, is only necessary if the OUTPUT policy is not 
set to ACCEPT.


Allow All Incoming HTTPS
To allow all incoming HTTPS (port 443) connections run these commands:
```
  sudo iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A OUTPUT -p tcp --sport 443 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
The second command, which allows the outgoing traffic of established HTTP connections, is only necessary if the OUTPUT policy is not 
set to ACCEPT.


Allow All Incoming HTTP and HTTPS
If you want to allow both HTTP and HTTPS traffic, you can use the multiport module to create a rule that allows both ports. 
To allow all incoming HTTP and HTTPS (port 443) connections run these commands:
```
  sudo iptables -A INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
The second command, which allows the outgoing traffic of established HTTP and HTTPS connections, is only necessary if the OUTPUT 
policy is not set to ACCEPT.


Flush All Chains
To flush all chains, which will delete all of the firewall rules, you may use the -F, or the equivalent --flush, option by itself:
```  sudo iptables -F```
  
  
Flush All Fules, Delete All Chains, and Accept all  
Set the default policies for each of the built-in chains to ACCEPT. The main reason to do this is to ensure that you won’t be locked 
out from your server via SSH:
```
  sudo iptables -P INPUT ACCEPT
  sudo iptables -P FORWARD ACCEPT
  sudo iptables -P OUTPUT ACCEPT
```
Then flush the nat and mangle tables, flush all chains (-F), and delete all non-default chains (-X):
```  sudo iptables -t nat -F```
  sudo iptables -t mangle -F
  sudo iptables -F
  sudo iptables -X
  

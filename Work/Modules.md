Modules is a software tool that allows you to set environment variable for a particular software package.
if a software is need to be installed first does this software needed on a cluster or a single node
if no install on the node itself
if yes install in /sw (mounted  hpchost3-a: /sw)

show all module

```
module avail
```

show module loaded

```
module list
```

load module

```
module load [module]
```

unload module

```
module unload [module] 
```

# install and config envirnoment module

``
 apt-get install environment-modules #ubuntu
 yum install environment-modules     #rhel

 ln -s /apps/sw /sw    #symlink /sw -> /apps/sw
```

add /apps/sw/com/modulefiles to the end of /usr/share/modules/init/.modulespath 
other distro may have the directory in a different location: /usr/share/Modules/init/.modulespath

```
echo '/sw/com/modulefiles' >> /usr/share/modules/init/.modulespath
```

for compute ndoes change the module path

```
vi /etc/environment
MODULEPATH="/usr/share/Modules/modulefiles:/etc/modulefiles:/usr/share/modulefiles:/apps/sw/com/modulefiles"

 module use [directory]
 module use /apps/sw/com/modulefiles
```



dnf install environment-modules
ln -s /apps/sw /sw
echo 'MODULEPATH="/usr/share/Modules/modulefiles:/etc/modulefiles:/usr/share/modulefiles:/apps/sw/com/modulefiles"' >> /etc/environment
reboot

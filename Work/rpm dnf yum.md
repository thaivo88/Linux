Installing and Removing Files

```
rpm -i --install (install new RPM; error if already installed)
rpm -U --upgrade (delete existing RPM, if any; install new)
rpm -F --freshen (update RPM only if package already installed)
rpm -e --erase (remove, delete, expunge)
```

Use a query for information about installed packages. You may query against all installed packages, or a single installed package. You may also find out which RPM supplies a particular file.

```
rpm -q [packages] [information]
rpm -qa (all installed packages)
rpm -q package_name
rpm -qf (filename)
rpm -qp (package filename)
```

Information
default (package name)

```
-i: general information
-l: file list
```

Examples:

```
rpm -qa
rpm -q kernel -i (information)
rpm -q kernel -l (files contained in package)
rpm -q kernel --requires (prereqs)
rpm -q kernel --provides (capabilities provided by package)
rpm -q kernel --scripts (scripts run during installation and removal)
rpm -q kernel --changelog (revision history)
rpm -q kernel -queryformat format (rpm --querytags for list of options)
```

```
rpm -qa | grep foo
```



Queries – Verification (Files)
The RPM database contains many attributes about each and every file installed by an RPM. You may verify the current status of the file against the information cataloged by RPM when the package was installed.

```
rpm -V package_name
rpm -Va (verify all)
rpm -Vf (filename)
rpm -Vp (package filename)
```

Queries – Verification (Packages)

```
rpm -import /mnt/cdrom/RPM-GPG-KEY
rpm -q gpg-pubkey
rpm --checksig m4-1.4.1-11.i386.rpm
```

Examples:

```
rpm -qf /path/filename (what package owns filename)
rpm -qf /path/filename -i (what does it do)
rpm -qp m4-1.4.1-11.i386.rpm -l (files in m4)
rpm -qp m4-1.4.1-11.i386.rpm --requires (prereqs needed to install m4)
rpm -q --whatprovides glibc.so (what package provides requisite library)
```


In a terminal you can search for packages with : 

```
sudo yum list <package-name>
```

To check for available software (not installed), execute : 

```
sudo yum list available
```

To check for software being already installed, execute : 

```
sudo yum list installed
```

To check for all software (available and installed), execute : 

```
sudo yum list all
```

list repo depo
```
sudo dnf repolist
repo id                                repo name
appstream                              Rocky Linux 8 - AppStream
baseos                                 Rocky Linux 8 - BaseOS
epel                                   Extra Packages for Enterprise Linux 8 - x86_64
extras                                 Rocky Linux 8 - Extras
kubernetes                             Kubernetes
```

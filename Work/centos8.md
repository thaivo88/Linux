Step 1: Mount CentOS 8 DVD Installation ISO File
```
mkdir /mnt/centos8
mount CentOS-8-x86_64-1905-dvd1.iso /mnt/centos8
```

Mount CentOS 8 ISO File
Step 2: Create a CentOS 8 Local Yum Repository
In the mounted directory where your ISO is mounted, copy the media.repo file to the /etc/yum.repos.d/ directory as shown.

```cp -v /mnt/centos8/media.repo  /etc/yum.repos.d/centos8.repo```

Create CentOS 8 Local Yum Repository
Next, assign file permissions as shown to prevent modification or alteration by other users.
```
chmod 644 /etc/yum.repos.d/centos8.repo
ls -l /etc/yum.repos.d/centos8.repo
```

Set Permission On Yum Repository File
We need to configure the default repository file residing on the system. To check the configurations, use the cat command as shown.

```cat /etc/yum.repos.d/centos8.repo```

Check Yum Repository File
We need to modify the configuration lines using a text editor of your choice.

```vi /etc/yum.repos.d/centos8.repo```

Delete all the configuration, and copy & paste the configuration below.
```
[InstallMedia-BaseOS]
name=CentOS Linux 8 - BaseOS
metadata_expire=-1
gpgcheck=1
enabled=1
baseurl=file:///mnt/centos8/BaseOS/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[InstallMedia-AppStream]
name=CentOS Linux 8 - AppStream
metadata_expire=-1
gpgcheck=1
enabled=1
baseurl=file:///mnt/centos8/AppStream/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
```

Save the repo file and exit the editor.
After modifying the repository file with new entries, proceed and clear the DNF / YUM cache as shown.
```
dnf clean all
```

To confirm that the system will get packages from the locally defined repositories, run the command:
```
dnf repolist
```

List Yum Repositories
Now set ‘enabled’ parameter from 1 to 0 in CentOS-AppStream.repo and CentOS-Base.repo files.
```
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/CentOS-AppStream.repo
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/CentOS-Base.repo
```

Step 3: Install Packages Using Local DNF or Yum Repository
Now, let’s give it a try and install any package. In this example, we are going to install NodeJS on the system.
```
dnf install nodejs
```

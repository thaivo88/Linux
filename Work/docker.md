# Docker Container

Install Docker on your system:
```
dnf install docker
```

Initiate the Docker system
```
service docker start
```

# Create a Container

To check if there are any pre-running containers on the system.
```
docker ps
```

Create a new container
(The command has various parts to it, the --name specifies the name of the container. ubuntu specifies the OS we want. 
/bin is the place where we want the main files to be stored.)
```
docker run -it --name [Container_name] [distro] /bin/bash
docker run -it --name thai-test ubuntu /bin/bash
```

To exit the container and get back to the Docker Engine
```
exit
```

Creating a container image
There are 3 ways to create a container image:

  1:  Via Docker Hub
  
  2:  Create an inmage from Docker File
  
  3:  Create an image from existing container


Create an image from existing container then creating a file:
```
docker run -it --name [Container_name] [distro] /bin/bash
docker run -it --name thai-test ubuntu /bin/bash
cd tmp
touch mytestfile
exit
docker commit [Container_name] [New_Container_name]
docker commit thai-test thai-testv2
```

Now we can check the images available by running:
```
docker images
```

Commands needed to create a Docker File:  
```
FROM – This command is for base image. This command must be on top of the Docker File
RUN – Used to execute the commands. This command will create layers in Image.
MAINTAINER – Author/Owner/Description.
COPY – Used to copy files from local system, need to provide source/destination. Cannot be used to download files from internet.
ADD – Similar to COPY but we can download files from the internet.
EXPOSE – To expose the ports such as 8080 port being used for Tomcat, Port 80 for Ngix etc.
WORK DIR – Set working directory.
CMD – Executes the commands during container creation.
ENTRYPOINT – Similar to CMD but has high priority. 
ENV – Environment variables.
```


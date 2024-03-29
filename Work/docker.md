# Docker Container

Install Docker on your system:
```
dnf install docker
```

Initiate the Docker system
```
service docker start
```


# Creating a container image
There are 3 ways to create a container image:

  1:  Via Docker Hub
  
  2:  Create an image from Docker File
  
  3:  Create an image from existing container


# Create an image from existing container then creating a file:
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


# Creating an image from docker file:

  1:  Create a docker file; naming "Dockerfile"
  
  2:  Add instructions in the file
  
  3:  Build "Dockerfile" to create the image
  
  4:  Rum the image to create the container by typing the bewlow command:
  
```
vi Dockerfile
# add the following to the file
FROM ubuntu
RUN ECHO "Sample" > /temp/testfile
# save and exit vi: (esc :x!)
```

To create the time out of the "Dockerfile" 
```
docker build -t [name_of_image] [directory_dockerfile]
docker build -t myimg .
docker ps -a
docker images
```

Create new container from the image
```
docker run -it --name [Container_name] [distro] /bin/bash
docker run -it --name thaiubuntu myimg /bin/bash
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


Private registry of the docker hub
```
docker login [server]
username:******
password:******
docker push   # to place an image to the registry
docker pull   # to retrieve an image from the registy
```

Docker Objects:

image (custom virtual file system for a given application) >> run >> container

![image](https://user-images.githubusercontent.com/15881158/220741840-07499a79-c768-4b57-8875-cc5a053ae973.png)

![image](https://user-images.githubusercontent.com/15881158/220742250-46d4d480-1610-4f92-b2ce-b1f1b090d262.png)



# Container Isolation

Pull image
```
docker image pull [image_name]
```

list images
```
docker image ls
```

Run the container
```
docker container run [image_name] [command]
docker container run alpine ls -l
```

list containers
```
docker container ls --all
```

using the container ID you can run the container with exec
```
docker container exec [container_ID] [command]
docker container exec b45 ls
```



![image](https://user-images.githubusercontent.com/15881158/220755584-29683e8a-246c-4506-831d-c560f020f8b1.png)

![image](https://user-images.githubusercontent.com/15881158/220755327-0d5056a7-7e64-448c-9a38-ae2a3fcdc33f.png)

![image](https://user-images.githubusercontent.com/15881158/220755472-b32aa57d-f523-4ad4-ad82-0e6ee4104b3b.png)


# Create a Docker volume

to display all volumes
```
docker volume ls
```

creating a volume called vol1
```
docker volume create [named_volume]
docker volume create vol1
```

to inspect the volume
```
docker volume inspect [named_volume]
docker volume inspect vol1
```

output of inspect:

![image](https://user-images.githubusercontent.com/15881158/220756701-6112cf4c-4a8a-46bc-bee6-83feca6f8f43.png)


Create the container using the following command:
```
docker run -it --name [container_name] –v [named_volume]:/[directory] [image]
docker run -it --name container1 –v vol1:/lab4 alpine
```
The -it tag tells the host to open the container within an interactive terminal. 
The name of the container is container1. 
The -v tag attaches the previously created volume, vol1 and creates a directory within the volume named lab4.


# Delete the container
Listing the available containers first then delete the selected container.
The created volume is still intact and can be used for other containers. 
```
docker container ls -a
docker rm [container_name]
```



![image](https://user-images.githubusercontent.com/15881158/220760291-8e55aabb-70ad-403a-b8eb-673756744076.png)




The -P flag tells Docker to map a random port to the local host

The -d flag tells the container to run detached, or in the background. 

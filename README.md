# Docker GEMC

This github will help you to build a docker container with the GEMC software in it.
In order to build the container you will need to have access to jlabsvn.jlab.org to download the software.

Currently I have been building in a Ubuntu 16.10 environment with qt5 copied another installation, since running a GUI during the build process is not possible.

I have not attempted to run graphics from this docker container, although it should be possible, in theory.

## Requirements

### For GEMC container
* Docker

On Debian/Ubuntu systems:
```
sudo apt-get install docker-ce
```

On RedHat/Centos systems:
```
sudo yum install docker-ce
```

## Building GEMC

To build in your own container clone the git repository and run:

```
docker build -t gemc:test gemc-go/.
```

To run the built container:
```
docker run -v`pwd`:/root/data -it gemc:test
```
Which will give you a tcsh shell and source jlab.csh.
It will also give you access to your current working directory.
This should be used for input and output of files.

## Using prebuilt GEMC

I have already taken the time to build GEMC and you can use the prebuilt version on any computer running docker.
First download the pre-built container with:
```
docker pull tylern4/gemc:latest
```

And run, similar to above, with:

```
docker run -v`pwd`:/root/data -it tylern4/gemc:latest
```

## Basic docker commands:
Change name:tag with what you would like to call your container and tag it. If
you don't include the tag it will automatically be called latest.

### Building:
```
docker build -t name:tag /path/to/Dockerfile
```
### Running:
```
docker run -v`pwd`:/root/data -it name:tag
```
The `-i` means interactive terminal.
The `-t` means tty.
Combined this will give you and interactive terminal you can run any of the CLAS6 software from.
The `-v` will add a volume to the docker container.
I usually add the current working directory to the container but you can add more paths by adding additional `-v /local/path:/container/path` to the existing command line.

### Looking at containers

To see the containers that are downloaded or built on your system use `docker images` or `docker images -a`.
To see the currently running containers you can run `docker ps -a`.

### Helpful functions
You can add these helpful functions to your `.bashrc`/`.zshrc` in order to manage docker container space.

```
# docker shortcuts
docker-rm() { docker rm $(docker ps -aq); }
docker-rmi() { docker rmi $(docker images -f "dangling=true" -q); }
```

### Run a single command

You can also modify the ENTRYPOINT at the end of the container in order to just run a single command.


## To Do
- [ ] Build qt5 in the container
- [ ] Be able to build in docker without csh
- [ ] Figure out how to use graphics for running

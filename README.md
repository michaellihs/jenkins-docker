Dockerized Jenkins
==================

This project brings a Jenkins Master running in a Docker container. The following features are included:

* Jenkins Master running in a container
* Persisted configuration and jobs
* Persisted logs

The idea of the project is taken from the series of blog posts [Putting Jenkins in a Docker Container](https://engineering.riotgames.com/news/putting-jenkins-docker-container) by Riot Games Engineering. All Kudos go to Maxfield F Stewart for providing this great blog post.



Prerequisites
-------------

These steps describe the setup on a Mac OS machine:

1. Install the Docker Toolbox from https://www.docker.com/products/docker-toolbox
2. Open the "Docker Quickstart Terminal"
3. Start the `Docker Quickstart Terminal` from your Applications folder
4. Configure the Docker client to use the host running in the VM via 

    `eval "$(docker-machine env default)"`

5. Clone this repository into some local directory and follow the command described in the "Using the Docker Image" section.



Using the Docker Images
-----------------------

This project contains several Docker files. One Dockerfile is used to start up a Jenkins master, another one starts volume containers that persist the data.

### Building the Docker Images

Run 
    
    docker build -t myjenkins jenkins-master/.
    docker build -t myjenkinsdata jenkins-data/.
    docker build -t myjenkinsconf jenkins-conf/.

to build the images

### Starting the Docker Images

Run 

    docker run --name=jenkins-data myjenkinsdata
    docker run --name=jenkins-conf myjenkinsconf
    docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master --volumes-from=jenkins-data --volumes-from=jenkins-conf -d myjenkins

to start the container. Jenkins should now be available at http://192.168.99.100:8080


### Stopping the Docker Image

Run 

    docker stop jenkins-master
    docker stop jenkins-data
    docker stop jenkins-conf
    docker rm jenkins-master
    docker rm jenkins-data
    docker rm jenkins-conf

### Accessing the Jenkins Logfiles inside the Container

Run

    docker exec jenkins-master tail -f /var/log/jenkins/jenkins.log

to read the logfiles, while the container is running. Use

    docker cp jenkins-master:/var/log/jenkins/jenkins.log jenkins.log
    cat jenkins.log

to read the logfiles, when the container is stopped or crashed (e.g. for debugging issues).



FAQ
===

Q: When I try to run a Docker command, I get `Cannot connect to the Docker daemon. Is the docker daemon running on this host?`<br>
A: Run `eval "$(docker-machine env default)"` to fix the issue.

Q: When I try to run a Docker command, I get `Network timed out while trying to connect to https://index.docker.io/v1/repositories/library/jenkins/images. You may want to check your internet connection or if you are behind a proxy.`<br>
A: Restart your Docker-machine with `docker-machine restart` to re-configure networking.



Resources
=========

* [Official Jenkins Image on Dockerhub](https://hub.docker.com/_/jenkins/)
* [Putting Jenkins in a Docker Container](https://engineering.riotgames.com/news/putting-jenkins-docker-container) by Riot Games Engineering
* [Docker & Jenkins - Data that persists](https://engineering.riotgames.com/news/docker-jenkins-data-persists) by Riot Games Engineering
* [Jenkins, Docker, Proxies and Compose](https://engineering.riotgames.com/news/jenkins-docker-proxies-and-compose) by Riot Games Engineering
* [Taking Control of your Docker Image](https://engineering.riotgames.com/news/taking-control-your-docker-image) by Riot Games Engineering
* [Understanding Volumes in Docker](http://container-solutions.com/understanding-volumes-docker/)



Author
======

Michael Lihs <mimi@kaktusteam.de>

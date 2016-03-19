# see https://hub.docker.com/r/library/jenkins/tags/ for current releases of the Docker image for Jenkins.
# 1.642.3 is current LTS, but it's not yet available as a Docker image.
FROM jenkins:1.642.2

MAINTAINER Michael Lihs <mimi@kaktusteam.de>

# Set Java and Jenkins ENV variables
ENV JAVA_OPTS="-Xmx1024m"
ENV JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log"

# Create a log folder for jenkins
USER root
RUN chown -R  jenkins:jenkins /var/log/jenkins
USER jenkins

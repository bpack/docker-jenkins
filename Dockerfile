FROM jenkins/jenkins:alpine

LABEL maintainer="ben.pack@gmail.com"

USER root

# Used for the docker group ID. Default is 497 (group ID used by AWS Linux ECS Instances)
ARG DOCKER_GID=497

# Used to control Docker and Docker Compose versions that are compatible with AWS Linux ECS.
ARG DOCKER_ENGINE=17.03.2-ce
ARG DOCKER_COMPOSE=1.17.0

ARG DOCKER_URL=https://download.docker.com/linux/static/stable/x86_64

RUN addgroup -g ${DOCKER_GID:-497} -S docker

RUN apk update && \
    apk --no-cache add sudo \
        git \
        curl \
        libffi-dev \
        linux-headers \
        python  \
        python-dev \
        py-setuptools \
        gcc \
        make \
        musl-dev \
        openssl-dev \
        py-pip && \
    curl -L -o /tmp/docker-${DOCKER_ENGINE:-17.03.2-ce}.tgz \
        ${DOCKER_URL}/docker-${DOCKER_ENGINE:-17.03.2-ce}.tgz && \
    tar -xz -C /tmp -f /tmp/docker-${DOCKER_ENGINE:-17.03.2-ce}.tgz && \
    mv /tmp/docker/docker /usr/bin && \
    pip install --upgrade pip && \
    pip install docker-compose==${DOCKER_COMPOSE:-1.17.0} && \
    pip install virtualenv ansible awscli boto boto3 && \
    addgroup jenkins docker && \
    addgroup jenkins users && \
    rm -rf /var/cache/apk/* \
        /var/lib/apt/lists \
        /usr/share/man \
        /tmp/*

USER jenkins

ENV JENKINS_USER admin
ENV JENKINS_PASS admin
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

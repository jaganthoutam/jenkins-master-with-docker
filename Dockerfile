FROM jenkins/jenkins:lts
USER root

ARG DOCKER_VERSION=17.06.2~ce-0~debian
ARG DC_VERSION=1.18.0

USER root


# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-slaves
# install Notifications and Publishing plugins
RUN /usr/local/bin/install-plugins.sh email-ext
RUN /usr/local/bin/install-plugins.sh mailer
RUN /usr/local/bin/install-plugins.sh slack
# Artifacts
RUN /usr/local/bin/install-plugins.sh htmlpublisher
# UI
RUN /usr/local/bin/install-plugins.sh greenballs
RUN /usr/local/bin/install-plugins.sh simple-theme-plugin
# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes
# git
RUN /usr/local/bin/install-plugins.sh git
#
RUN /usr/local/bin/install-plugins.sh workflow-job
RUN /usr/local/bin/install-plugins.sh workflow-aggregator
RUN /usr/local/bin/install-plugins.sh credentials-binding



RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      maven  \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" && \
    apt-get update && \
    apt-get install nfs-common -y && \
    apt-get install -qq -y --no-install-recommends docker-ce=${DOCKER_VERSION} && \
    curl -L https://github.com/docker/compose/releases/download/${DC_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

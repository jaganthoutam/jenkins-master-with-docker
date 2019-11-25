FROM jenkins/jenkins:lts

# Running as root to have an easy support for Docker
USER root

# A default ADMIN user NOT SAFE............
ENV ADMIN_USER=admin \
    ADMIN_PASSWORD=password

# Jenkins init scripts
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/

# Install plugins at Docker image build time
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/plugins.txt) && \
    mkdir -p /usr/share/jenkins/ref/ && \
    echo lts > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo lts > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

# Install Docker
RUN apt-get -qq update && \
    apt-get -qq -y install curl && \
    curl -sSL https://get.docker.com/ | sh

# Install Maven
RUN curl -LO https://www-eu.apache.org/dist/maven/maven-3/3.6.2/source/apache-maven-3.6.2-src.tar.gz && \
    tar xzf apache-maven-3.6.2-src.tar.gz && \
    mv ./apache-maven-3.6.2 /opt/apache-maven | sh
ENV PATH=/opt/apache-maven/bin:$PATH
#**********script-security plugin not safe use at won risk****************
ENV _JAVA_OPTIONS="-Djdk.net.URLClassPath.disableClassPathURLCheck=true -Dpermissive-script-security.enabled=true"

# ENV M2_HOME="/opt/apache-maven"

# Install kubectl and helm
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

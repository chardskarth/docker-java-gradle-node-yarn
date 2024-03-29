FROM openjdk:11
MAINTAINER Richard Glen Domingo

RUN apt-get update
RUN apt-get -y install wget curl unzip xz-utils python build-essential ssh git locales openssh-client

ENV YARN_VERSION 1.22.4
ENV NODE_VERSION 12.22.6
ENV GRADLE_VERSION 7.2
ENV ESLINT_VERSION 7.32.0

# Configure locale to UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Install nodejs via nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# Install gradle
ENV GRADLE_HOME /gradle-$GRADLE_VERSION
ENV PATH ${PATH}:$GRADLE_HOME/bin
RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
    unzip gradle-$GRADLE_VERSION-bin.zip && \
    rm -f gradle-$GRADLE_VERSION-bin.zip

RUN npm i --global yarn@$YARN_VERSION
RUN npm i --global eslint@$ESLINT_VERSION


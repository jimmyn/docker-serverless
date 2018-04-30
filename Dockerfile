FROM amazonlinux:latest

ENV SERVERLESS serverless@1.26.1
ENV NODE_VERSION 8.10.0
ENV NVM_DIR /usr/local/nvm

RUN yum -y install zip glibc-devel gcc patch git gcc-c++ java-1.8.0-openjdk
RUN yum clean all

# install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py
RUN pip install --upgrade pip

# install aws cli
RUN pip install awscli --upgrade --user

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash &&\
    . $NVM_DIR/nvm.sh &&\
    nvm install $NODE_VERSION

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# install yarn
RUN npm i -g yarn

# install serverless
RUN yarn global add $SERVERLESS

#required for local dynamoDB
EXPOSE 8000

#required for serverless offline
EXPOSE 3000

WORKDIR /opt/app

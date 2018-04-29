FROM amazonlinux:latest

ENV SERVERLESS serverless@1.26.1

# Create .bashrc file
RUN touch ~/.bashrc

# Install node 8.10, latest yarn and serverless
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
RUN source ~/.bashrc && \
    nvm install 8.10.0 && \
    npm i -g yarn && \
    yarn global add $SERVERLESS

RUN yum -y install zip make glibc-devel gcc patch git gcc-c++

# install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py
RUN pip install --upgrade pip

# install aws cli
RUN pip install awscli --upgrade --user

WORKDIR /opt/app

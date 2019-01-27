FROM ubuntu:16.04
LABEL AUTHOR "Exadatum XCatalyst <xcatalyst@exadatum.com>"

# configure the Terraform version here
ENV TERRAFORM_VERSION=0.11.11

RUN apt-get update -yqq \
    && apt-get install -yqq \
        build-essential \
        curl \
        file \
        git \
        bash \
        openssh \
        apt-transport-https \
        lsb-release \
        software-properties-common \
        dirmngr

RUN add-apt-repository ppa:longsleep/golang-backports \
    && apt-get update \
    && apt-get install golang-go

RUN AZ_REPO=$(lsb_release -cs) \ 
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    tee /etc/apt/sources.list.d/azure-cli.list

RUN apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
     --keyserver packages.microsoft.com \
     --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF \
    && apt-get update \
    && apt-get install azure-cli

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ \
    && git checkout v${TERRAFORM_VERSION} \
    && /bin/bash scripts/build.sh

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

RUN brew install terragrunt

# Start in root's home
WORKDIR /root
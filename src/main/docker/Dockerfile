FROM ubuntu:16.04
LABEL AUTHOR "Exadatum XCatalyst <xcatalyst@exadatum.com>"

# Configure the Terraform version here
ENV TERRAFORM_VERSION=0.11.11
ENV TERRAGRUNT_VERSION=0.17.4
ENV TERRAGRUNT_USER=tgrunt
ENV TERRAGRUNT_GROUP=tgrunt
ENV TERRAGRUNT_UID=200
ENV TERRAGRUNT_GID=200

# Install common dependencies
RUN apt-get update -yqq \
    && apt-get install -yqq \
        build-essential \
        curl \
        file \
        git \
        bash \
        apt-transport-https \
        lsb-release \
        software-properties-common \
        dirmngr \
        wget

# Install go
RUN add-apt-repository ppa:longsleep/golang-backports \
    && apt-get update -yqq \
    && apt-get install -yqq golang-go

# Install azure cli
RUN AZ_REPO=$(lsb_release -cs) \ 
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
     --keyserver packages.microsoft.com \
     --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF \
    && apt-get update -yqq \
    && apt-get install -yqq azure-cli

# Install terraform
ENV TF_DEV=true
ENV TF_RELEASE=true
ENV GOPATH=$HOME/go
ENV PATH=$GOPATH/bin:$PATH
RUN mkdir -p $GOPATH/src/github.com/hashicorp/terraform \
    && cd $GOPATH/src/github.com/hashicorp/terraform \
    && git clone https://github.com/hashicorp/terraform.git ./ \
    && git checkout v${TERRAFORM_VERSION} \
    && /bin/bash scripts/build.sh

# Install terragrunt
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 \
    &&  mv terragrunt_linux_amd64 /go/bin/terragrunt \
    && chmod +x /go/bin/terragrunt

# Add tgrunt user
RUN groupadd -g ${TERRAGRUNT_GID} ${TERRAGRUNT_GROUP} \
    && useradd -u ${TERRAGRUNT_UID} -g ${TERRAGRUNT_GROUP} -m -s /bin/bash ${TERRAGRUNT_USER}
USER ${TERRAGRUNT_USER}:${TERRAGRUNT_GROUP}

# Start in user's home
WORKDIR /home/${TERRAGRUNT_USER}
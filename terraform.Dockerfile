FROM swr.ap-southeast-3.myhuaweicloud.com/codeci/special_base_image:ubuntu18-base-intl-1.0.2
USER build

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install openssh-client git curl wget gpg lsb-release jq python3 -y
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update
RUN apt-get install terraform
RUN terraform -install-autocomplete
RUN curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash
RUN wget https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
RUN rm -rf /usr/local/go
RUN tar -C /usr/local -xzf go1.20.5.linux-amd64.tar.gz
RUN apt-get install python3-distutils python3.8 -y
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.8 get-pip.py
RUN pip3.8 install checkov
ENV PATH=$PATH:/usr/local/go/bin
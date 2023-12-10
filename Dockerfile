FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /home/models

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    wget \
    fail2ban \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    python3 \
    python3-venv \
    libgl1 \
    libglib2.0-0 \
    lshw \
    sudo \
    pip \
    make

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Setup SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Install Conda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh && \
    bash Anaconda3-2023.09-0-Linux-x86_64.sh -b -p /anaconda && \
    rm Anaconda3-2023.09-0-Linux-x86_64.sh

ENV PATH="/home/models/.local/bin:/anaconda/bin:${PATH}"
ENV PATH="/anaconda/bin:${PATH}"
RUN echo "source /anaconda/etc/profile.d/conda.sh" >> /etc/profile

RUN useradd -m -s /bin/bash models && echo "models:root" | chpasswd && adduser models sudo
RUN echo 'models ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY ./Makefile /home/models/

EXPOSE 22 2375 7865

# Start SSH service
CMD service ssh start && tail -f /dev/null
FROM debian:11

RUN apt-get update && apt-get install openssh-server -y; \
    mkdir -p /run/sshd
    
COPY ./authorized_keys /root/.ssh/

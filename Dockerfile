FROM debian:11

RUN apt-get update && apt-get install \
    openssh-server \
    python3 \
    && mkdir -p /run/sshd
    
COPY ./authorized_keys /root/.ssh/

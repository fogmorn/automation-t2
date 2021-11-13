FROM debian:11

RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
    && mkdir -p /run/sshd
    
COPY ./authorized_keys /root/.ssh/

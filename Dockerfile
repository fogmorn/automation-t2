FROM debian:11

RUN apt-get update && apt-get install openssh-server -y
    
COPY ./authorized_keys /root/.ssh/

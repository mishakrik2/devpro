# Base image

FROM alpine:latest

# Install terraform and git

RUN apk add terraform git
RUN git clone -b jenkins https://github.com/mishakrik2/devpro.git 
RUN cd /devpro/terraform && terraform init
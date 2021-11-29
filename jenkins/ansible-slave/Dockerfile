# Base image

FROM alpine:latest

# Install terraform and git

RUN apk add ansible git bash && \
    ansible-galaxy collection install amazon.aws

COPY terraform/ec2-rsa.pem /root/key/ec2-rsa.pem
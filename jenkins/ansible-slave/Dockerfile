# Base image

FROM alpine:latest

# Install terraform and git

RUN apk add ansible git bash && \
    ansible-galaxy collection install amazon.aws

ENV ANSIBLE_LOCAL_TEMP=/tmp/.ansible/tmp
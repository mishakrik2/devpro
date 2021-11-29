# Base image

FROM alpine:latest

# Install terraform and git

RUN apk add ansible git bash && \
    ansible-galaxy collection install amazon.aws

ENV ANSIBLE_REMOTE_TMP=/var/git/tmp
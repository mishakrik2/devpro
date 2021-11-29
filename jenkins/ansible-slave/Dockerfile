# Base image

FROM alpine:latest

# Install terraform and git

RUN apk add ansible py3-botocore py3-boto3 git bash && \
    ansible-galaxy collection install amazon.aws

ENV ANSIBLE_LOCAL_TEMP=/tmp/.ansible/tmp
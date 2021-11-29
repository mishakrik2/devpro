# Base image

FROM alpine:latest

# Install terraform and git

COPY jenkins/terraform-slave/credentials.sh /credentials.sh
RUN apk add terraform git bash

#!/bin/bash

#Define cleanup procedure
cleanup() {
    echo "Container stopped, performing cleanup..."
}

#Trap SIGTERM
trap 'cleanup' SIGTERM

#Execute a command
"${@}" &

#Wait
wait $!
#!/bin/bash

set -e

export AWS_SDK_LOAD_CONFIG="true"

#Run docker file

cd ../..
podman build -t thisworks:01 .

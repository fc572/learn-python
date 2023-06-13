#!/bin/bash

set -e

eval $(ssh-agent)
echo "SSH_AUTH_SOCK ${SSH_AUTH_SOCK}"
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
cd /tmp


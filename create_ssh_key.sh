#!/bin/dumb-init /bin/sh
set -e

# the script is being executed by the root user
ATLANTIS_HOME=/home/atlantis

if [ -n "$GITHUB_USER_SSH_KEY" ]; then
  if [ ! -d "$ATLANTIS_HOME/.ssh" ]; then
    mkdir "$ATLANTIS_HOME/.ssh"
  fi

  if [ ! -f "$ATLANTIS_HOME/.ssh/id_rsa" ]; then
    echo "$GITHUB_USER_SSH_KEY" > "$ATLANTIS_HOME/.ssh/id_rsa"

    chmod 600 "$ATLANTIS_HOME/.ssh/id_rsa"

    ssh-keyscan github.com >> "$ATLANTIS_HOME/.ssh/known_hosts"

    chown atlantis:atlantis "$ATLANTIS_HOME/.ssh/id_rsa"
    chown atlantis:atlantis "$ATLANTIS_HOME/.ssh/known_hosts"
  fi
fi

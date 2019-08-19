#!/bin/dumb-init /bin/sh
set -e

create_ssh_key.sh

set -- docker-entrypoint-original.sh "$@"

exec "$@"

#!/usr/bin/env bash
[ -d /docker-entrypoint.d ] && IFS=$'\n' eval 'for f in $(find /docker-entrypoint.d/ -type f -print |sort); do source ${f}; done'
exec $@

#!/usr/bin/env bash
set -x
CATALINA_SH="${CATALINA_HOME}/bin/catalina.sh"

if [ "$(basename $1)" == 'catalina.sh' ]; then
  [ -d /docker-entrypoint.d ] && IFS=$'\n' eval 'for f in $(find /docker-entrypoint.d/ -type f -print |sort); do source ${f}; done'

  [ "${2}" == "start" ] && exec $CATALINA_SH run ${@:3}
  exec $CATALINA_SH ${@:2}
fi

exec $@

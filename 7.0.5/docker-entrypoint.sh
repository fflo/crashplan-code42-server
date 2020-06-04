#!/bin/bash
set -e

# adapt TIMEZONE if requested
if [[ ${TIMEZONE} ]]; then
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi

# start proserver as user crashplan
if [[ "$1" =~ 'run.sh' ]]; then
  exec gosu crashplan "$@"
fi

exec "$@"

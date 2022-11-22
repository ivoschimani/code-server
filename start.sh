#!/bin/sh

if [ -n "${PASSWORD}" ]; then
  AUTH="password"
else
  AUTH="none"
  echo "starting with no password"
fi

if [ -n "$GIT.MAIL" ] ; then git config --global user.email "$GIT.MAIL" ; fi
if [ -n "$GIT.USER" ] ; then git config --global user.name "$GIT.USER" ; fi

exec code-server --bind-addr 0.0.0.0:8080 --user-data-dir /data/data --extensions-dir /data/extensions --disable-telemetry --disable-updates --auth "${AUTH}" /data/workspace

#!/bin/bash

mkdir -vp /data/www-static-resources /data/eea.controlpanel
chown plone:plone /data/www-static-resources /data/eea.controlpanel

if [ ! -z "$TRACEVIEW" ]; then
    /usr/sbin/traceview-config $TRACEVIEW
    /etc/init.d/tracelyzer start
fi

exec /kgs-entrypoint.sh "$@"

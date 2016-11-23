#!/bin/bash

if [ ! -z "$TRACEVIEW" ]; then
    /usr/sbin/traceview-config $TRACEVIEW
    /etc/init.d/tracelyzer start
fi

exec gosu plone /plone-entrypoint.sh "$@"

#!/bin/bash

bin/develop up

if [ -z "$1" ]; then
  exec cat
fi

exec "$@"

#!/bin/bash

bin/develop rb

if [ -z "$1" ]; then
  exec cat
fi

exec "$@"

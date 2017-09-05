#!/bin/bash
set -e

bin/develop rb

if [ -z "$1" ]; then
  echo "============================================================="
  echo "All set. Now you can dive into container and start debugging:"
  echo "                                                             "
  echo "    $ docker exec -it <container_name_or_id> bash            "
  echo "    $ ps aux                                                 "
  echo "    $ bin/instance fg                                        "
  echo "                                                             "
  echo "============================================================="
  exec cat
fi

if [ "$1" == "tests" ]; then
 for i in $(ls src); do
   if [ ! -z "$EXCLUDE" ]; then
     if [ $EXCLUDE == *"$i"* ]; then
       echo "============================================================="
       echo "Skipping tests for: $i                                       "
       continue
     fi
   fi

   echo "============================================================="
   echo "Running tests for:                                           "
   echo "                                                             "
   echo "    $i                                                       "
   echo "                                                             "

   ./bin/test -v -vv -s $i
  done
fi

exec "$@"

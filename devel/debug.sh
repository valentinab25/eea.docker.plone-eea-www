#!/bin/bash

bin/develop rb

echo "============================================================="
echo "All set. Now you can dive into container and start debugging:"
echo "                                                             "
echo "    $ docker exec -it <container_name_or_id> bash            "
echo "    $ ps aux                                                 "
echo "    $ bin/instance fg                                        "
echo "                                                             "
echo "============================================================="

if [ -z "$1" ]; then
  exec cat
fi

exec "$@"

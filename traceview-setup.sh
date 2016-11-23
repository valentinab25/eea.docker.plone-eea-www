#!/bin/bash

apt-get update
apt-get install -y --no-install-recommends apt-transport-https

echo "========================================================================="
echo "Installing AppNeta TraceView..."
echo "========================================================================="

echo "tracelyzer.access_key=$TRACEVIEW" > /etc/tracelytics.conf
echo "deb https://apt.tv.solarwinds.com/$TRACEVIEW jessie main" > /etc/apt/sources.list.d/appneta.list
curl https://apt.tv.solarwinds.com/appneta-apt-key.pub | apt-key add -

apt-get update
apt-get install -y --no-install-recommends liboboe0 liboboe-dev tracelyzer

echo "========================================================================="
echo "Cleanup...                                                                                                       "
echo "========================================================================="

rm -rf /var/lib/apt/lists/* \
rm -rf /var/cache/* \
rm -rf /tmp/*

# Will configure TraceView in container
exit 0

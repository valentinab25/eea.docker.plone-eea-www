#!/bin/bash

echo "========================================================================="
echo "Installing AppNeta TraceView..."
echo "========================================================================="

apt-get install -y --no-install-recommends tracelyzer

echo "========================================================================="
echo "Cleaning up apt-get cache..."
echo "========================================================================="

apt-get clean
rm -vrf /var/lib/apt/lists/*
rm -vrf /var/cache/* \
rm -vrf /tmp/*

# Will configure TraceView in container
exit 0

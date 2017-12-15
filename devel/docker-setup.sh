#!/bin/bash

runDeps="
  build-essential
"

echo "========================================================================="
echo "Installing $runDeps"
echo "========================================================================="

apt-get update
apt-get install -y --no-install-recommends $runDeps

echo "========================================================================="
echo "Running buildout -c devel.cfg"
echo "========================================================================="

buildout -c devel.cfg

echo "========================================================================="
echo "Cleaning up cache..."
echo "========================================================================="

rm -vrf /var/lib/apt/lists/*
rm -vrf /plone/buildout-cache/downloads/*

echo "========================================================================="
echo "mkrelease..."
echo "========================================================================="

ln -s /plone/instance/bin/mkrelease /usr/local/bin/mkrelease
ln -s /plone/instance/tools/mkrelease-pypi /usr/local/bin/mkrelease-pypi

echo "========================================================================="
echo "Fixing permissions..."
echo "========================================================================="

chown -R plone:plone /plone /data

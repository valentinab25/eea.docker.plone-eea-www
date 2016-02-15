#!/bin/bash
set -e

buildDeps="
  build-essential
  libldap2-dev
  libsasl2-dev
"

echo "========================================================================="
echo "Installing $buildDeps"
echo "========================================================================="

apt-get update
apt-get install -y --no-install-recommends $buildDeps


echo "========================================================================="
echo "Running buildout -c buildout.cfg"
echo "========================================================================="

buildout -c buildout.cfg

echo "========================================================================="
echo "Unininstalling $buildDeps"
echo "========================================================================="

apt-get purge -y --auto-remove $buildDeps


echo "========================================================================="
echo "Cleaning up cache..."
echo "========================================================================="

find . -name "*eea.plonebuildout.profile*.zcml" -exec rm -vf {} \;
rm -vrf /var/lib/apt/lists/*
rm -vrf /plone/buildout-cache/downloads/*

echo "========================================================================="
echo "Fixing permissions..."
echo "========================================================================="

mkdir -p /data/www-static-resources /data/eea.controlpanel
chown -R plone:plone /plone /data

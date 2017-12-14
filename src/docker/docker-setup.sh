#!/bin/bash

set -e

buildDeps="
  build-essential
  libldap2-dev
  libsasl2-dev
  liboboe-dev
"

runDeps="
  liboboe0
"

apt-get update
apt-get install -y --no-install-recommends apt-transport-https

echo "========================================================================="
echo "AppNeta TraceView..."
echo "========================================================================="

echo "tracelyzer.access_key=$TRACEVIEW" > /etc/tracelytics.conf
echo "deb https://apt.tv.solarwinds.com/$TRACEVIEW jessie main" > /etc/apt/sources.list.d/appneta.list
curl https://apt.tv.solarwinds.com/appneta-apt-key.pub | apt-key add -

echo "========================================================================="
echo "Installing $buildDeps"
echo "========================================================================="

apt-get update
apt-get install -y --no-install-recommends $buildDeps

echo "========================================================================="
echo "Installing $runDeps"
echo "========================================================================="

apt-get install -y --no-install-recommends $runDeps

echo "========================================================================="
echo "Running buildout -c buildout.cfg"
echo "========================================================================="

buildout -c buildout.cfg

echo "========================================================================="
echo "Unininstalling $buildDeps"
echo "========================================================================="

apt-get purge -y --auto-remove $buildDeps

echo "========================================================================="
echo "Cleaning up Plone cache..."
echo "========================================================================="

rm -vrf /plone/buildout-cache/downloads/*

echo "========================================================================="
echo "Fixing permissions..."
echo "========================================================================="

mkdir -p /data/www-static-resources /data/eea.controlpanel
chown -R plone:plone /plone /data

echo "========================================================================="
echo "Backward compatibility..."
echo "========================================================================="

ln -vs /data /var/sharedblobstorage
ln -vs /data/www-static-resources /var/www-static-resources

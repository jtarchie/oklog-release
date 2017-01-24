#!/bin/bash

set -ex

oklog_ver="0.1.2"
oklog_bin="oklog-$oklog_ver-linux-amd64"
if [ ! -e blobs/$oklog_bin ]; then
  wget https://github.com/oklog/oklog/releases/download/v$oklog_ver/$oklog_bin \
    -O /tmp/$oklog_bin
  bosh add-blob /tmp/$oklog_bin $oklog_bin
fi

bosh -n -e lite create-release --force --name oklog
bosh -n -e lite upload-release --rebase
bosh -n -e lite update-cloud-config ./bosh-lite/cloud-config.yml
bosh -n -e lite -d oklog deploy ./bosh-lite/manifest.yml

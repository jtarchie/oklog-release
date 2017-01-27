#!/bin/bash

set -ex

bosh -n -e lite create-release --force --name oklog
bosh -n -e lite upload-release --rebase
bosh -n -e lite -d oklog deploy ./manifests/manifest.yml

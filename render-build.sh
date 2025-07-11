#!/usr/bin/env bash

# Fail fast on errors
set -o errexit

# Install Node.js and Yarn (uses a NodeSource PPA)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs yarn

# Precompile Rails assets with a dummy secret key
SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

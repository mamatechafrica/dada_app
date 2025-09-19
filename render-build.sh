#!/usr/bin/env bash

# Fail fast on errors
set -o errexit

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

# Install npm dependencies
npm install

# Build CSS assets
npm run build:css

# Install Ruby dependencies
bundle install

# Run database migrations
bundle exec rails db:migrate

# Seed database (only if RAILS_ENV is production and DB is empty)
if [ "$RAILS_ENV" = "production" ]; then
  bundle exec rails db:seed
fi

# Precompile Rails assets
bundle exec rails assets:precompile

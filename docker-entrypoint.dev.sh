#!/bin/sh
set -e

# Install dependencies
mix deps.get

# Install node modules
cd assets && npm install && cd ..

exec "$@"

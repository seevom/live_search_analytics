#!/bin/sh
set -e

# Install dependencies
mix deps.get

# Install node modules
cd assets && npm install && cd ..

# Run migrations if they exist
mix ecto.create || true
mix ecto.migrate || true

exec "$@"

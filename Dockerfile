FROM elixir:1.15-alpine

# Install build dependencies
RUN apk add --no-cache build-base git nodejs npm

WORKDIR /app

# Install hex package manager and Phoenix framework
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

# Copy configuration files
COPY mix.exs mix.lock ./
COPY config config

# Install mix dependencies
RUN mix deps.get

# Copy assets
COPY assets assets
COPY priv priv
COPY lib lib

# Build assets
RUN cd assets && npm install

# Compile the project
RUN mix do compile

CMD ["mix", "phx.server"]

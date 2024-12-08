# Use multi-stage build for smaller final image
FROM elixir:1.15-alpine AS builder

# Install build dependencies
RUN apk add --no-cache build-base git nodejs npm python3 && \
    npm install -g npm@latest webpack webpack-cli

# Set environment variables
ENV MIX_ENV=prod \
    NODE_ENV=production

WORKDIR /app

# Install hex package manager and Phoenix framework
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

# Copy mix.exs first to install dependencies
COPY mix.exs ./

# Install mix dependencies
RUN mix deps.get --only prod && \
    mix deps.compile

# Copy configuration files
COPY config config

# Copy assets and build them
COPY assets assets
RUN cd assets && \
    npm install --no-audit --no-fund --include=dev && \
    NODE_ENV=production npx webpack --mode production

# Copy all application code
COPY lib lib
COPY priv priv

# Compile and build release
RUN mix do compile, assets.deploy

# Generate release
RUN mix release

# Start a new build stage
FROM alpine:3.18

# Install runtime dependencies
RUN apk add --no-cache libstdc++ openssl ncurses-libs

ENV MIX_ENV=prod

WORKDIR /app

# Copy release from builder stage
COPY --from=builder /app/_build/prod/rel/live_search_analytics ./

# Create a non-root user and set permissions
RUN adduser -D app && \
    chown -R app: /app
USER app

# Set runtime environment
ENV HOME=/app \
    PORT=4000

# Expose port
EXPOSE 4000

# Start the Phoenix app
CMD ["bin/live_search_analytics", "start"]

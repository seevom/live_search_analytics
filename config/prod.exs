import Config

config :live_search_analytics, LiveSearchAnalyticsWeb.Endpoint,
  url: [host: System.get_env("PHX_HOST", "localhost"), port: 443, scheme: "https"],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

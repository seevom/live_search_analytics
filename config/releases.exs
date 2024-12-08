import Config

config :live_search_analytics, LiveSearchAnalyticsWeb.Endpoint,
  server: true,
  http: [port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  check_origin: false

config :live_search_analytics, :meilisearch,
  host: System.get_env("MEILISEARCH_HOST"),
  api_key: System.get_env("MEILISEARCH_KEY")

import Config

# For development, we disable any cache and enable
# debugging and code reloading.
config :live_search_analytics, LiveSearchAnalyticsWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  http: [ip: {0, 0, 0, 0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "your_dev_secret_key_base",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
  ]

# Watch static and templates for browser reloading.
config :live_search_analytics, LiveSearchAnalyticsWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/live_search_analytics_web/(controllers|live|components)/.*(ex|heex)$",
      ~r"lib/live_search_analytics_web/templates/.*(eex)$"
    ]
  ]

# Enable dev routes for dashboard and mailbox
config :live_search_analytics, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

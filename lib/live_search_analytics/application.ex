defmodule LiveSearchAnalytics.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveSearchAnalyticsWeb.Telemetry,
      {Phoenix.PubSub, name: LiveSearchAnalytics.PubSub},
      LiveSearchAnalyticsWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: LiveSearchAnalytics.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    LiveSearchAnalyticsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

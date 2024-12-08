defmodule LiveSearchAnalyticsWeb.Router do
  use LiveSearchAnalyticsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveSearchAnalyticsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveSearchAnalyticsWeb do
    pipe_through :browser

    live "/", SearchLive
  end

  # Other scopes may use custom stacks.
  scope "/api", LiveSearchAnalyticsWeb do
    pipe_through :api
    
    post "/seed", SeedController, :create
    # Add API routes here
  end
end

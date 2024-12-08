defmodule LiveSearchAnalyticsWeb.Gettext do
  @moduledoc """
  A module providing Internationalization with a gettext-based API.
  """
  use Gettext.Backend, otp_app: :live_search_analytics
end

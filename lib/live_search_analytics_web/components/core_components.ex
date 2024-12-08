defmodule LiveSearchAnalyticsWeb.CoreComponents do
  use Phoenix.Component

  def flash(assigns) do
    ~H"""
    <div
      :if={msg = Phoenix.Flash.get(@flash, @kind)}
      class="rounded-lg p-4 mb-4 text-sm"
      class={[
        @kind == :info && "bg-blue-100 text-blue-700",
        @kind == :error && "bg-red-100 text-red-700"
      ]}
      phx-click="lv:clear-flash"
      phx-value-key={@kind}
      role="alert"
    >
      <%= msg %>
    </div>
    """
  end

  def flash_group(assigns) do
    ~H"""
    <div class="fixed top-0 flex items-start justify-center right-0 px-4 py-6 pointer-events-none sm:p-6 sm:items-start sm:justify-end z-50">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />
    </div>
    """
  end
end

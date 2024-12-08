defmodule LiveSearchAnalyticsWeb.SearchLive do
  use LiveSearchAnalyticsWeb, :live_view
  alias LiveSearchAnalytics.Search

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: [], analytics: %{total_searches: 0, popular_terms: []})}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    results = Search.perform_search(query)
    analytics = Search.update_analytics(query)
    
    {:noreply, assign(socket, results: results, analytics: analytics)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="container mx-auto px-4 py-8">
      <h1 class="text-4xl font-bold mb-8">LiveSearch Analytics</h1>
      
      <form phx-submit="search" class="mb-8">
        <input type="text" name="q" value={@query}
               class="w-full px-4 py-2 rounded border border-gray-300 focus:outline-none focus:border-blue-500"
               placeholder="Search..."
               phx-debounce="300"
        />
      </form>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <div class="bg-white p-6 rounded-lg shadow">
          <h2 class="text-2xl font-semibold mb-4">Search Results</h2>
          <div class="space-y-4">
            <%= for result <- @results do %>
              <div class="p-4 border rounded">
                <h3 class="font-semibold"><%= result.title %></h3>
                <p class="text-gray-600"><%= result.description %></p>
              </div>
            <% end %>
          </div>
        </div>

        <div class="bg-white p-6 rounded-lg shadow">
          <h2 class="text-2xl font-semibold mb-4">Real-time Analytics</h2>
          <div class="space-y-4">
            <div>
              <h3 class="font-semibold">Total Searches</h3>
              <p class="text-2xl"><%= @analytics.total_searches %></p>
            </div>
            <div>
              <h3 class="font-semibold">Popular Search Terms</h3>
              <ul class="list-disc pl-5">
                <%= for {term, count} <- @analytics.popular_terms do %>
                  <li><%= term %> (<%= count %> searches)</li>
                <% end %>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end

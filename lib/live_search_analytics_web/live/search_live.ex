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
    
    {:noreply, assign(socket, query: query, results: results, analytics: analytics)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="container mx-auto px-4 py-8">
      <h1 class="text-4xl font-bold mb-8 text-center">LiveSearch Analytics</h1>
      
      <form phx-submit="search" phx-change="search" class="mb-8">
        <input type="text" 
               name="q" 
               value={@query}
               class="w-full px-4 py-2 rounded border border-gray-300 focus:outline-none focus:border-blue-500"
               placeholder="Search..."
               autocomplete="off"
               phx-debounce="300"
        />
      </form>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <div class="bg-white p-6 rounded-lg shadow">
          <h2 class="text-2xl font-semibold mb-4">Search Results</h2>
          <%= if Enum.empty?(@results) do %>
            <p class="text-gray-500">No results found</p>
          <% else %>
            <div class="space-y-4">
              <%= for result <- @results do %>
                <div class="p-4 border rounded hover:shadow-md transition-shadow">
                  <h3 class="font-semibold"><%= result["title"] %></h3>
                  <p class="text-gray-600 mt-2"><%= result["description"] %></p>
                </div>
              <% end %>
            </div>
          <% end %>
        </div>

        <div class="bg-white p-6 rounded-lg shadow">
          <h2 class="text-2xl font-semibold mb-4">Real-time Analytics</h2>
          <div class="space-y-6">
            <div>
              <h3 class="font-semibold text-lg">Total Searches</h3>
              <p class="text-3xl font-bold text-blue-600"><%= @analytics.total_searches %></p>
            </div>
            
            <div>
              <h3 class="font-semibold text-lg mb-3">Popular Search Terms</h3>
              <div class="space-y-2">
                <%= for {term, count} <- @analytics.popular_terms do %>
                  <div class="flex justify-between items-center">
                    <span class="text-gray-700"><%= term %></span>
                    <span class="bg-blue-100 text-blue-800 px-2 py-1 rounded"><%= count %></span>
                  </div>
                <% end %>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end

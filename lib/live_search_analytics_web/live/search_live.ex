defmodule LiveSearchAnalyticsWeb.SearchLive do
  use LiveSearchAnalyticsWeb, :live_view
  alias LiveSearchAnalytics.Search

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, 
      query: "", 
      results: [], 
      analytics: %{total_searches: 0, popular_terms: []},
      selected_document: nil,
      show_modal: false
    )}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    results = Search.perform_search(query)
    analytics = Search.update_analytics(query)
    
    {:noreply, assign(socket, query: query, results: results, analytics: analytics)}
  end

  @impl true
  def handle_event("view-document", %{"id" => id}, socket) do
    document = Enum.find(socket.assigns.results, &(&1["id"] == id))
    {:noreply, assign(socket, selected_document: document, show_modal: true)}
  end

  @impl true
  def handle_event("close-modal", _, socket) do
    {:noreply, assign(socket, show_modal: false, selected_document: nil)}
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
                <div class="p-4 border rounded hover:shadow-md transition-shadow cursor-pointer"
                     phx-click="view-document"
                     phx-value-id={result["id"]}>
                  <h3 class="font-semibold text-blue-600 hover:text-blue-800">
                    <%= result["title"] %>
                  </h3>
                  <p class="text-gray-600 mt-2"><%= result["content"] %></p>
                  <div class="mt-2 flex flex-wrap gap-2">
                    <%= for tag <- result["tags"] || [] do %>
                      <span class="bg-gray-100 text-gray-700 px-2 py-1 rounded-full text-sm">
                        <%= tag %>
                      </span>
                    <% end %>
                  </div>
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

      <%= if @show_modal and @selected_document do %>
        <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4">
          <div class="bg-white rounded-lg p-6 max-w-2xl w-full max-h-[80vh] overflow-y-auto">
            <div class="flex justify-between items-start mb-4">
              <h2 class="text-2xl font-bold"><%= @selected_document["title"] %></h2>
              <button phx-click="close-modal" class="text-gray-500 hover:text-gray-700">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
            <div class="prose max-w-none">
              <p class="text-gray-700 mb-4"><%= @selected_document["content"] %></p>
              <div class="flex flex-wrap gap-2">
                <%= for tag <- @selected_document["tags"] || [] do %>
                  <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full">
                    <%= tag %>
                  </span>
                <% end %>
              </div>
            </div>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end

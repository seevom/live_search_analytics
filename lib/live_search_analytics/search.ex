defmodule LiveSearchAnalytics.Search do
  @meilisearch_host System.get_env("MEILISEARCH_HOST", "http://localhost:7700")
  @meilisearch_key System.get_env("MEILISEARCH_KEY", "")

  def perform_search(query) when byte_size(query) > 0 do
    {:ok, client} = Meilisearch.Client.new(@meilisearch_host, @meilisearch_key)
    
    case Meilisearch.Search.search(client, "documents", query) do
      {:ok, results} -> 
        results.hits
      _ -> 
        []
    end
  end
  
  def perform_search(_), do: []

  def update_analytics(query) do
    # In a real application, you'd want to store this in a persistent store
    # For demo purposes, we'll just return mock data
    %{
      total_searches: :rand.uniform(1000),
      popular_terms: [
        {query, :rand.uniform(100)},
        {"example", 45},
        {"search", 30},
        {"analytics", 25}
      ]
    }
  end

  def index_document(document) do
    {:ok, client} = Meilisearch.Client.new(@meilisearch_host, @meilisearch_key)
    Meilisearch.Documents.add_or_replace(client, "documents", [document])
  end
end

defmodule LiveSearchAnalytics.Search do
  use HTTPoison.Base
  
  @meilisearch_host System.get_env("MEILI_URL", "http://meilisearch:7700")
  @meilisearch_key System.get_env("MEILI_MASTER_KEY", "")
  @table_name :search_analytics

  # Initialize ETS table when the module is loaded
  def init do
    :ets.new(@table_name, [:named_table, :set, :public])
  end

  def perform_search(query) when byte_size(query) > 0 do
    url = "#{@meilisearch_host}/indexes/documents/search"
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{@meilisearch_key}"}
    ]
    body = Jason.encode!(%{q: query})

    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"hits" => hits}} -> hits
          _ -> []
        end
      _ ->
        []
    end
  end
  
  def perform_search(_), do: []

  def update_analytics(query) when byte_size(query) > 0 do
    # Get current timestamp
    timestamp = System.system_time(:second)
    
    # Update search count
    case :ets.lookup(@table_name, query) do
      [{^query, count, _last_searched}] ->
        :ets.insert(@table_name, {query, count + 1, timestamp})
      [] ->
        :ets.insert(@table_name, {query, 1, timestamp})
    end

    # Get analytics data
    all_terms = :ets.tab2list(@table_name)
    total_searches = Enum.reduce(all_terms, 0, fn {_, count, _}, acc -> acc + count end)
    
    # Get popular terms (top 5)
    popular_terms = all_terms
      |> Enum.sort_by(fn {_, count, _} -> count end, :desc)
      |> Enum.take(5)
      |> Enum.map(fn {term, count, _} -> {term, count} end)

    %{
      total_searches: total_searches,
      popular_terms: popular_terms
    }
  end

  def update_analytics(_), do: %{total_searches: 0, popular_terms: []}

  def index_document(document) do
    url = "#{@meilisearch_host}/indexes/documents/documents"
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{@meilisearch_key}"}
    ]
    body = Jason.encode!([document])

    # First ensure the index exists
    create_index()

    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: status_code}} when status_code in 200..299 ->
        {:ok, document}
      error ->
        error
    end
  end

  defp create_index do
    url = "#{@meilisearch_host}/indexes/documents"
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{@meilisearch_key}"}
    ]
    body = Jason.encode!(%{primaryKey: "id"})

    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: status_code}} when status_code in 200..299 ->
        :ok
      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"message" => "index_already_exists"}} -> :ok
          _ -> :error
        end
      _ ->
        :error
    end
  end
end

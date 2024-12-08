defmodule LiveSearchAnalytics.Search do
  use HTTPoison.Base

  @meilisearch_host System.get_env("MEILI_URL", "http://meilisearch:7700")
  @meilisearch_key System.get_env("MEILI_MASTER_KEY", "")

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

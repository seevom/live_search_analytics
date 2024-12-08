alias LiveSearchAnalytics.Search

# Sample documents
documents = [
  %{
    id: "1",
    title: "Introduction to Elixir",
    content: "Elixir is a dynamic, functional language for building scalable and maintainable applications.",
    tags: ["programming", "elixir", "functional"]
  },
  %{
    id: "2",
    title: "Phoenix Framework",
    content: "Phoenix is a web framework for Elixir that makes building web applications fast and easy.",
    tags: ["web", "phoenix", "elixir"]
  },
  %{
    id: "3",
    title: "LiveView Tutorial",
    content: "Learn how to build interactive web applications with Phoenix LiveView without writing JavaScript.",
    tags: ["tutorial", "phoenix", "liveview"]
  },
  %{
    id: "4",
    title: "Search Analytics",
    content: "Implementing real-time search analytics with Meilisearch and Phoenix LiveView.",
    tags: ["search", "analytics", "meilisearch"]
  }
]

# Index each document
Enum.each(documents, fn document ->
  case Search.index_document(document) do
    {:ok, _} -> IO.puts("Indexed document: #{document.title}")
    error -> IO.puts("Error indexing document: #{inspect(error)}")
  end
end)

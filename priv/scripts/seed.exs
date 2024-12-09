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
  },
  %{
    id: "5",
    title: "Concurrency in Elixir",
    content: "Understand how Elixir leverages the BEAM VM to handle millions of concurrent processes efficiently.",
    tags: ["concurrency", "elixir", "beam"]
  },
  %{
    id: "6",
    title: "Distributed Systems with Elixir",
    content: "Building fault-tolerant distributed systems using Elixir and OTP.",
    tags: ["distributed", "elixir", "otp"]
  },
  %{
    id: "7",
    title: "Elixir Metaprogramming",
    content: "Learn how to write macros and leverage metaprogramming to reduce boilerplate code in Elixir.",
    tags: ["metaprogramming", "elixir", "macros"]
  },
  %{
    id: "8",
    title: "Real-time Chat with Phoenix Channels",
    content: "A guide to building a real-time chat application using Phoenix Channels.",
    tags: ["real-time", "chat", "phoenix"]
  },
  %{
    id: "9",
    title: "Testing in Elixir",
    content: "Best practices for writing robust tests in Elixir using ExUnit and other testing tools.",
    tags: ["testing", "elixir", "exunit"]
  },
  %{
    id: "10",
    title: "Deploying Elixir Applications",
    content: "An overview of deploying Elixir applications with releases, Docker, and Kubernetes.",
    tags: ["deployment", "elixir", "kubernetes"]
  },
  %{
    id: "11",
    title: "Healthy Meal Prep Tips",
    content: "Learn how to plan and prepare healthy meals for the week ahead.",
    tags: ["health", "meal prep", "nutrition"]
  },
  %{
    id: "12",
    title: "Top Travel Destinations 2024",
    content: "Discover the most popular travel destinations for the upcoming year.",
    tags: ["travel", "destinations", "2024"]
  },
  %{
    id: "13",
    title: "Investing for Beginners",
    content: "A beginner's guide to understanding the basics of investing and growing your wealth.",
    tags: ["finance", "investing", "beginners"]
  },
  %{
    id: "14",
    title: "Effective Time Management",
    content: "Tips and strategies to manage your time effectively and boost productivity.",
    tags: ["productivity", "time management", "efficiency"]
  },
  %{
    id: "15",
    title: "AI and the Future of Work",
    content: "Exploring how artificial intelligence is reshaping industries and the workforce.",
    tags: ["technology", "AI", "future"]
  }
]

# Index each document
Enum.each(documents, fn document ->
  case Search.index_document(document) do
    {:ok, _} -> IO.puts("Indexed document: #{document.title}")
    error -> IO.puts("Error indexing document: #{inspect(error)}")
  end
end)

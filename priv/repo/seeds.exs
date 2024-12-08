# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias LiveSearchAnalytics.Search

# Sample documents
documents = [
  %{
    id: "1",
    title: "Introduction to Phoenix LiveView",
    description: "Learn how to build interactive web applications with Phoenix LiveView"
  },
  %{
    id: "2",
    title: "Real-time Search with Meilisearch",
    description: "Implement fast and relevant search functionality using Meilisearch"
  },
  %{
    id: "3",
    title: "Analytics Dashboard Design",
    description: "Best practices for designing real-time analytics dashboards"
  },
  %{
    id: "4",
    title: "Elixir Performance Tips",
    description: "Optimize your Elixir applications for better performance"
  },
  %{
    id: "5",
    title: "Docker Deployment Guide",
    description: "Step-by-step guide to deploying Phoenix applications with Docker"
  }
]

# Index each document
Enum.each(documents, &Search.index_document/1)

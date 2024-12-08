# LiveSearch Analytics

A real-time search analytics dashboard built with Elixir, Phoenix LiveView, and Meilisearch.

## Features

- Real-time search interface
- Search analytics dashboard
- Interactive Livebook notebooks
- REST API endpoints
- Dockerized deployment

## Quick Start

1. Clone the repository
2. Make sure you have Docker and Docker Compose installed
3. Run the application:
   ```bash
   docker-compose up --build
   ```
4. Access the applications:
   - Main application: http://localhost:4000
   - Meilisearch admin: http://localhost:7700
   - Livebook: http://localhost:8080

## Development

The project uses:
- Elixir/Phoenix for the backend
- Phoenix LiveView for real-time features
- Meilisearch for fast search capabilities
- Livebook for interactive development

## Environment Variables

Create a `.env` file with:
```
MEILISEARCH_HOST=http://meilisearch:7700
MEILISEARCH_KEY=your_master_key
LIVEBOOK_PASSWORD=your_password
SECRET_KEY_BASE=your_secret_key_base
```

## Architecture

The application is split into three main services:
1. Phoenix application (main app)
2. Meilisearch (search engine)
3. Livebook (interactive development)

All services are containerized and can be run with a single docker-compose command.

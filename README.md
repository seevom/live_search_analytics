# LiveSearch Analytics Platform

A real-time search analytics platform that provides instant search results and comprehensive search analytics. Built with Elixir and Phoenix LiveView, this platform demonstrates modern search capabilities with analytics tracking.

## 🚀 Tech Stack

### Backend
- **Elixir** (1.15.x) - Functional programming language
- **Phoenix Framework** (1.7.x) - Web framework
- **Phoenix LiveView** (0.20.x) - Real-time UI without JavaScript
- **HTTPoison** - HTTP client for API integration
- **ETS (Erlang Term Storage)** - In-memory analytics storage

### Search Engine
- **Meilisearch** (v1.11.3)
  - Typo-tolerant search
  - Real-time indexing
  - Custom ranking rules
  - RESTful API

### Development Tools
- **Docker** & **Docker Compose** - Containerization
- **Mix** - Build and dependency management
- **Tailwind CSS** - Styling
- **esbuild** - Asset bundling

## 🛠️ Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Basic knowledge of Elixir/Phoenix (optional)

### Development Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd live_search_analytics
```

2. Start the development environment:
```bash
docker-compose -f docker-compose.dev.yml up --build
```

3. Load sample data:
```bash
docker-compose -f docker-compose.dev.yml exec app mix run priv/scripts/seed.exs
```

4. Visit [http://localhost:4000](http://localhost:4000)

### Environment Variables
Configuration in `docker-compose.dev.yml`:
```yaml
MEILI_URL=http://meilisearch:7700
MEILI_MASTER_KEY=8OTycdB8pDM6KiieO8j1Jxn_Uszk6nKwgraq7hcFHW8
SECRET_KEY_BASE=VG9YwqbJGYc+H+8OeHg0RMnlKEHp5/YtLh3K0yRhGGwlqcHaVGxLnPZlPMwuqL+B4XiGpkOPqD+hGqnKwLgvig==
```

## 🔍 Features

### Search Functionality
- Real-time search results
- Typo-tolerant searching
- Multi-field search (title, content, tags)
- Relevancy-based results

### Analytics Dashboard
- Total search count tracking
- Popular search terms
- Real-time analytics updates
- Search pattern analysis

### Sample Data
Includes demo documents about:
- Elixir programming
- Phoenix Framework
- LiveView tutorials
- Search analytics

## 📊 Analytics Features

The platform tracks:
- Number of searches performed
- Most popular search terms
- Search trends over time
- User engagement metrics

Data is stored in ETS tables for:
- Fast access
- Real-time updates
- Memory-efficient storage
- Process-safe operations

## 🚀 Production Deployment

1. Update environment variables in `docker-compose.yml`
2. Build and start containers:
```bash
docker-compose up --build
```

### Production Considerations
- Set up persistent Meilisearch volume
- Configure proper security settings
- Set up monitoring and logging
- Implement authentication if needed

## 🔧 Common Issues & Solutions

### Development
- If search returns no results, ensure seed data is loaded
- For live reload warnings, ignore in development
- Container restart required after certain config changes

### Search Engine
- Meilisearch needs a few seconds to index new documents
- Search index is cleared on container restart
- Run seed script to reload sample data

## 📝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License

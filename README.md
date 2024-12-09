Here’s an updated version of your README with a more detailed section on using Daytona to enhance the development process:

---

# Sample Elixir/Phoenix Application

A real-time search analytics platform that provides instant search results and comprehensive search analytics.

---

## 🚀 Getting Started  

### Open Using Daytona  

1. **Install Daytona**: Follow the [Daytona installation guide](https://www.daytona.io/docs/installation/installation/).  
2. **Create the Workspace**:  
   ```bash  
   daytona create https://github.com/Sourabh7iwari/live_search_analytics.git 
   ```  

3. **Launch the Application**: Daytona automates the setup of the development container, ensuring that all dependencies, configurations, and environment variables are in place.  
   - The application will start running on `localhost:4000`.  

4. **Seed the Demo Data**: If the demo search results are not visible, run the following command inside the app's Docker container:  
   ```bash  
   mix run priv/scripts/seed.exs
   ```  

---

## ✨ Features  

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

---

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

---

## 🛠️ How Daytona Enhances Development  

### Simplified Containerized Development  

Daytona helps streamline software development by automating containerized workflows. Here's how you can use it in this project:  

1. **Automatic Workspace Creation**:  
   - Daytona automatically provisions the necessary Docker containers based on the `devcontainer.json` or `docker-compose.yml` file in your repository.  
   - You don't need to manually set up dependencies or configurations.  

2. **Integrated Development Environment**:  
   - Daytona integrates with your preferred code editors, such as VS Code.  
   - It opens a fully configured development environment with pre-installed extensions and tools defined in the project settings.  


3. **Live Collaboration**:  
   - Use Daytona's collaborative features to work with your team in real time.  
   - Share the development environment securely and allow teammates to debug, test, or review.  

4. **Debugging and Logs**:  
   - Daytona provides a centralized interface for managing container logs and debugging issues.  
   - Access logs from your app containers or services (e.g., database, Meilisearch) directly from the Daytona CLI or UI.  

5. **Seamless Deployment Preparation**:  
   - Test your production build directly in a Daytona workspace.  
   - Simulate production environments using configuration overrides and test your `docker-compose.yml` setup before deployment.

---

## 🚀 Production Deployment

1. Update environment variables in `docker-compose.yml`
2. Build and start containers:
   ```bash
   docker-compose up --build
   ```  

---

## 📚 Additional Resources  

- **Daytona Documentation**: [https://www.daytona.io/docs](https://www.daytona.io/docs)  
- **Elixir/Phoenix Framework**: [https://phoenixframework.org/](https://phoenixframework.org/)  
- **LiveView Tutorials**: [https://hexdocs.pm/phoenix_live_view](https://hexdocs.pm/phoenix_live_view)  


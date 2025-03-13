# The House that Code Built

A Flask application that visualizes web development concepts through an interactive house metaphor with toggleable SVG layers. Features automatic GitHub Pages deployment for sharing your visualization online!

## Getting Started

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- Git (for version control and GitHub Pages deployment)

### Setup and Running the Application

1. Create a `.env` file in the root directory with your GitHub information:
   ```
   # GitHub Pages Configuration
   GITHUB_USERNAME="TortoiseWolfe"
   REPO_NAME="The_House_that_Code_Built"
   GITHUB_PAGES_URL="https://${GITHUB_USERNAME}.github.io/${REPO_NAME}"
   
   # Flask configuration
   FLASK_APP=House_Code/app.py
   FLASK_ENV=development
   FLASK_DEBUG=1
   ```
   ⚠️ This is important for proper GitHub Pages deployment later!

2. Run the setup script to create the project structure:
   ```
   bash FirstFlask.sh
   ```
   This will create a `House_Code` directory with all necessary files.

3. Navigate to the generated project directory:
   ```
   cd House_Code
   ```

4. Start the application with Docker:
   ```
   docker-compose up
   ```

5. Access the application in your browser at:
   ```
   http://localhost:5000
   ```
   ⚠️ Note: Make sure to use `localhost:5000` and not any IP address shown in Docker logs.

6. To stop the application:
   - Press `Ctrl+C` in the terminal where docker-compose is running
   - Or run: `docker-compose down` from another terminal

### Deploying to GitHub Pages (Automated)

The project includes automatic GitHub Pages deployment using GitHub Actions:

1. First, make sure your `.env` file in the root directory has the correct GitHub information:
   ```
   GITHUB_USERNAME="TortoiseWolfe"
   REPO_NAME="The_House_that_Code_Built" 
   ```

2. Push your repository to GitHub:
   ```bash
   # Initialize git repository if needed
   git init
   git add .
   git commit -m "Initial commit"
   
   # Add GitHub remote
   git remote add origin https://github.com/TortoiseWolfe/The_House_that_Code_Built.git
   
   # Push to GitHub
   git push -u origin main
   ```

3. Enable GitHub Pages in your repository settings:
   - Go to your GitHub repository
   - Click on "Settings" tab
   - Navigate to "Pages" in the left sidebar
   - Under "Build and deployment" section, select:
     - Source: "GitHub Actions"
   - Click "Save"

4. Your site will be automatically deployed each time you push to the main branch!
   - You can view the deployment status in the "Actions" tab of your repository
   - Once deployed, your site will be available at the URL specified in your `.env` file:
     ```
     https://TortoiseWolfe.github.io/The_House_that_Code_Built
     ```

### Understanding the Project Structure

The project creates these key files and directories:

- `.env` - Configuration file for GitHub Pages deployment
- `House_Code/` - Main project directory
  - `app.py` - Main Flask application
  - `templates/index.html` - HTML template with interactive controls
  - `static/svg/` - Directory for SVG assets
  - `Dockerfile` & `docker-compose.yml` - Docker configuration
  - `.github/workflows/github-pages.yml` - GitHub Actions workflow for automatic deployment

## Features

- Interactive SVG layer toggling
- Preset chapter views for different web development concepts
- Responsive design
- Docker containerization for easy development
- Automatic GitHub Pages deployment
- Environment variable configuration

## SVG Layers Explained

The application visualizes web development concepts using these interactive SVG layers:

- **Environment Layer** - The background setting for our house
- **House Structure** - The basic house outline and foundation
- **HTML Tags Layer** - Visualizes HTML elements as the blueprint
- **Structure Layer** - Shows the HTML structural framing
- **CSS Design Layer** - Represents styling and visual design
- **JavaScript Layer** - Demonstrates interactive elements
- **Backend Systems Layer** - Illustrates server-side components

Each layer can be toggled on/off in the interactive interface to understand how different technologies combine to create a complete web application.

![House Code Prints](https://github.com/TortoiseWolfe/FirstFlask/blob/main/_svg_assets/houseCodePrints.png?raw=true)

## Technical Details

- **Flask** - Python web framework for the application backend
- **Docker** - Containerization for consistent development environment
- **GitHub Actions** - Automatic deployment to GitHub Pages
- **SVG** - Vector graphics for interactive visualization layers
- **JavaScript** - Client-side interactivity for toggling layers 
- **CSS** - Styling and responsive design
# Trigger rebuild Wed Mar 12 08:45:06 PM EDT 2025

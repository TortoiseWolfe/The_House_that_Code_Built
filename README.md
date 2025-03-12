# FlaskFirst - Web Development House Visualizer

A Flask application that visualizes web development concepts through an interactive house metaphor with toggleable SVG layers.

## Getting Started

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Setup and Running the Application

1. Clone this repository:
   ```
   git clone git@github.com:TortoiseWolfe/FirstFlask.git
   cd FlaskFirst
   ```

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

5. Access the application in your browser:
   ```
   http://localhost:5000
   ```

6. To stop the application:
   - Press `Ctrl+C` in the terminal where docker-compose is running
   - Or run: `docker-compose down` from another terminal

## Features

- Interactive SVG layer toggling
- Preset chapter views for different web development concepts
- Responsive design
- Docker containerization for easy deployment

## Project Structure

- `app.py` - Main Flask application
- `templates/index.html` - HTML template with interactive controls
- `static/svg/` - Directory for SVG assets
- `_svg_assets/` - Source SVG files used by the application

## SVG Assets

The application uses the following SVG layers:
- environment-layer.svg - Background environment
- house-structure.svg - Basic house structure
- html-tags-layer.svg - HTML tags visualization
- structure-layer.svg - HTML structural elements
- css-design-layer.svg - CSS styling layer
- interactive-layer.svg - JavaScript interactivity layer
- systems-layer.svg - Backend systems layer

#!/bin/bash
set -e

# Project name configuration
PROJECT_NAME="House_Code"

# Check if the project directory already exists
if [ -d "$PROJECT_NAME" ]; then
    echo "Directory '$PROJECT_NAME' already exists. Updating existing files..."
else
    echo "Creating project directory structure..."
    mkdir -p "$PROJECT_NAME/static/svg"
    mkdir -p "$PROJECT_NAME/templates"
fi

# Create the Flask application file (app.py)
cat > "$PROJECT_NAME/app.py" << 'EOF'
from flask import Flask, render_template, send_from_directory

app = Flask(__name__)

@app.route('/')
def index():
    # Layer information
    layers = [
        {"id": "environment-layer", "name": "Environment", "default": True},
        {"id": "house-structure", "name": "House Structure", "default": True},
        {"id": "html-tags-layer", "name": "HTML Tags", "default": False},
        {"id": "structure-layer", "name": "HTML Structure", "default": False},
        {"id": "css-design-layer", "name": "CSS Design", "default": False},
        {"id": "interactive-layer", "name": "JavaScript Interactivity", "default": False},
        {"id": "systems-layer", "name": "Backend Systems", "default": False}
    ]
    
    # Chapter presets
    chapters = [
        {
            "name": "Base House",
            "preset": "base",
            "description": "The complete house with all visual elements",
            "layers": ["environment-layer", "house-structure"]
        },
        {
            "name": "Chapter 1: HTML Tags",
            "preset": "html-tags",
            "description": "The blueprint layer showing HTML tags",
            "layers": ["environment-layer", "house-structure", "html-tags-layer"]
        },
        {
            "name": "Chapter 2: HTML Structure",
            "preset": "html-structure",
            "description": "The structural framing of the house",
            "layers": ["environment-layer", "structure-layer"]
        },
        {
            "name": "Chapter 3: CSS Design",
            "preset": "css-design",
            "description": "The design layer with visual styling",
            "layers": ["environment-layer", "house-structure", "css-design-layer"]
        },
        {
            "name": "Chapter 4: JavaScript",
            "preset": "javascript",
            "description": "The interactive elements that respond to events",
            "layers": ["environment-layer", "house-structure", "interactive-layer"]
        },
        {
            "name": "Chapter 5: Backend",
            "preset": "backend",
            "description": "The internal systems that power the house",
            "layers": ["environment-layer", "house-structure", "systems-layer"]
        }
    ]
    
    return render_template('index.html', layers=layers, chapters=chapters)

@app.route('/svg/<path:filename>')
def serve_svg(filename):
    # First try to look in static/svg
    try:
        return send_from_directory('static/svg', filename)
    except:
        # If not found, try to get from _svg_assets
        try:
            return send_from_directory('../_svg_assets', filename)
        except:
            # Return a placeholder SVG if all else fails
            return f'''
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 600">
              <rect width="800" height="600" fill="none" stroke="#ccc" stroke-width="1"/>
              <text x="400" y="300" font-family="Arial" font-size="24" text-anchor="middle" fill="#999">
                {filename} (not found)
              </text>
            </svg>
            ''', 200, {'Content-Type': 'image/svg+xml'}

if __name__ == '__main__':
    # Listen on all interfaces so the container is accessible externally
    app.run(debug=True, host='0.0.0.0')
EOF

# Create the HTML template for the layer toggler
cat > "$PROJECT_NAME/templates/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Web Development House - Layer Toggler</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
      background-color: #f5f5f5;
    }
    
    h1, h2 {
      color: #2e7d32;
    }
    
    h1 {
      text-align: center;
      margin-bottom: 30px;
    }
    
    .container {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }
    
    .controls-panel {
      background-color: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .layer-toggles {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-bottom: 20px;
    }
    
    .toggle-btn {
      padding: 10px 15px;
      background-color: #e0e0e0;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-size: 14px;
    }
    
    .toggle-btn:hover {
      background-color: #d0d0d0;
    }
    
    .toggle-btn.active {
      background-color: #4CAF50;
      color: white;
      box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }
    
    .divider {
      height: 1px;
      background-color: #e0e0e0;
      margin: 20px 0;
    }
    
    .preset-buttons {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }
    
    .preset-btn {
      padding: 12px 18px;
      background-color: #2196F3;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
      font-weight: bold;
    }
    
    .preset-btn:hover {
      background-color: #1976D2;
    }
    
    .preset-btn.active {
      background-color: #0D47A1;
      box-shadow: 0 2px 5px rgba(0,0,0,0.3);
    }
    
    .svg-container {
      background-color: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      min-height: 600px;
      position: relative;
    }
    
    .svg-layer {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      transition: opacity 0.3s ease;
    }
    
    .svg-layer.hidden {
      opacity: 0;
      pointer-events: none;
    }
    
    .chapter-description {
      background-color: #e8f5e9;
      padding: 10px 15px;
      border-radius: 4px;
      margin: 10px 0;
      font-style: italic;
    }
    
    @media (max-width: 600px) {
      .layer-toggles, .preset-buttons {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
  <h1>Web Development House - Layer Toggler</h1>
  
  <div class="container">
    <div class="controls-panel">
      <h2>Layer Controls</h2>
      
      <div class="layer-toggles">
        {% for layer in layers %}
        <button class="toggle-btn {% if layer.default %}active{% endif %}" data-layer="{{ layer.id }}">{{ layer.name }}</button>
        {% endfor %}
      </div>
      
      <div class="divider"></div>
      
      <h2>Chapter Presets</h2>
      <div class="preset-buttons">
        {% for chapter in chapters %}
        <button class="preset-btn {% if chapter.preset == 'base' %}active{% endif %}" data-preset="{{ chapter.preset }}">{{ chapter.name }}</button>
        {% endfor %}
      </div>
      
      <div class="chapter-description" id="chapter-description">
        {{ chapters[0].description }}
      </div>
    </div>
    
    <div class="svg-container" id="svg-container">
      <!-- SVG layers will be loaded here -->
    </div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Layer configuration from Flask
      const layers = {{ layers | tojson }};
      
      // Chapter presets from Flask
      const chapters = {{ chapters | tojson }};
      
      // Load all SVG layers
      loadSvgLayers();
      
      // Set up toggle buttons
      setupToggleButtons();
      
      // Set up preset buttons
      setupPresetButtons();
      
      // Load all SVG layers
      function loadSvgLayers() {
        const svgContainer = document.getElementById('svg-container');
        
        // Clear existing content
        svgContainer.innerHTML = '';
        
        // Load each layer as an SVG object
        layers.forEach(layer => {
          const svgObject = document.createElement('object');
          svgObject.className = 'svg-layer';
          svgObject.id = layer.id + '-svg';
          svgObject.type = 'image/svg+xml';
          svgObject.data = `/svg/${layer.id}.svg`;
          
          // Set initial visibility
          if (!layer.default) {
            svgObject.classList.add('hidden');
          }
          
          svgContainer.appendChild(svgObject);
        });
      }
      
      // Set up layer toggle buttons
      function setupToggleButtons() {
        const toggleButtons = document.querySelectorAll('.toggle-btn');
        
        toggleButtons.forEach(button => {
          button.addEventListener('click', function() {
            const layerId = this.getAttribute('data-layer');
            const svgObject = document.getElementById(layerId + '-svg');
            
            // Toggle button active state
            this.classList.toggle('active');
            
            // Toggle layer visibility
            if (svgObject) {
              svgObject.classList.toggle('hidden');
            }
          });
        });
      }
      
      // Set up chapter preset buttons
      function setupPresetButtons() {
        const presetButtons = document.querySelectorAll('.preset-btn');
        const descriptionElement = document.getElementById('chapter-description');
        
        presetButtons.forEach(button => {
          button.addEventListener('click', function() {
            const presetId = this.getAttribute('data-preset');
            
            // Update active button
            presetButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            
            // Apply the preset
            const chapter = chapters.find(ch => ch.preset === presetId);
            if (chapter) {
              // Update chapter description
              descriptionElement.textContent = chapter.description;
              
              // Update layer visibility
              layers.forEach(layer => {
                const layerId = layer.id;
                const svgObject = document.getElementById(layerId + '-svg');
                const toggleButton = document.querySelector(`.toggle-btn[data-layer="${layerId}"]`);
                
                if (chapter.layers.includes(layerId)) {
                  // Show this layer
                  if (svgObject) svgObject.classList.remove('hidden');
                  if (toggleButton) toggleButton.classList.add('active');
                } else {
                  // Hide this layer
                  if (svgObject) svgObject.classList.add('hidden');
                  if (toggleButton) toggleButton.classList.remove('active');
                }
              });
            }
          });
        });
      }
    });
  </script>
</body>
</html>
EOF

# Create the requirements.txt file
cat > "$PROJECT_NAME/requirements.txt" << 'EOF'
Flask==2.3.3
EOF

# Create the Dockerfile
cat > "$PROJECT_NAME/Dockerfile" << 'EOF'
# Use an official Python runtime as a base image
FROM python:3.11-slim

# Set environment variables to prevent Python from writing .pyc files and to enable unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the entire application code into the container
COPY . /app

# Expose port 5000 for the Flask application
EXPOSE 5000

# Define the command to run the Flask app
CMD ["python", "app.py"]
EOF

# Create docker-compose.yml file
cat > "$PROJECT_NAME/docker-compose.yml" << 'EOF'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - ./static:/app/static
      - ./_svg_assets:/app/_svg_assets
    restart: unless-stopped
EOF

# Copy existing SVG files if available, otherwise create placeholders
if [ -d "_svg_assets" ]; then
    echo "Found _svg_assets directory, copying SVG files..."
    for layer in "environment-layer" "house-structure" "html-tags-layer" "structure-layer" "css-design-layer" "interactive-layer" "systems-layer"; do
        if [ -f "_svg_assets/$layer.svg" ]; then
            cp "_svg_assets/$layer.svg" "$PROJECT_NAME/static/svg/$layer.svg"
            echo "Copied $layer.svg"
        else
            # Create placeholder if the file doesn't exist
            cat > "$PROJECT_NAME/static/svg/$layer.svg" << EOF
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 600">
  <!-- Placeholder for $layer SVG -->
  <rect width="800" height="600" fill="none" stroke="#ccc" stroke-width="1"/>
  <text x="400" y="300" font-family="Arial" font-size="24" text-anchor="middle" fill="#999">$layer</text>
</svg>
EOF
            echo "Created placeholder for $layer.svg"
        fi
    done
else
    echo "No _svg_assets directory found, creating placeholder SVG files..."
    # Create placeholder SVG files
    for layer in "environment-layer" "house-structure" "html-tags-layer" "structure-layer" "css-design-layer" "interactive-layer" "systems-layer"; do
        cat > "$PROJECT_NAME/static/svg/$layer.svg" << EOF
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 600">
  <!-- Placeholder for $layer SVG -->
  <rect width="800" height="600" fill="none" stroke="#ccc" stroke-width="1"/>
  <text x="400" y="300" font-family="Arial" font-size="24" text-anchor="middle" fill="#999">$layer</text>
</svg>
EOF
    done
fi

# Create a README in the project to explain how to use SVG assets
cat > "$PROJECT_NAME/README.md" << 'EOF'
# Web Development House - Layer Toggler

This is a Flask application that allows you to visualize web development concepts using a house metaphor with interactive SVG layers.

## Using SVG Assets

If you have SVG assets in the _svg_assets directory, they will be automatically used by the application.
Required SVG files:
- environment-layer.svg
- house-structure.svg
- html-tags-layer.svg
- structure-layer.svg
- css-design-layer.svg
- interactive-layer.svg
- systems-layer.svg

## Starting the Application

1. Start the application: docker-compose up
2. Access at http://localhost:5000
3. To stop: Ctrl+C or docker-compose down
EOF

echo "Project setup complete! Directory structure has been created at '$PROJECT_NAME'"
echo ""
echo "Next steps:"
echo "1. Navigate to the '$PROJECT_NAME' directory: cd $PROJECT_NAME"
echo "2. Start the application: docker-compose up"
echo "3. Access the application at http://localhost:5000"
echo ""
echo "To stop the application, press Ctrl+C or run: docker-compose down"
echo ""
echo "Note: SVG assets from the _svg_assets directory will be used automatically."

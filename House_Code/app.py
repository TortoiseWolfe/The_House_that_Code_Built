import os
from flask import Flask, render_template, send_from_directory
from dotenv import load_dotenv

# Load environment variables from the root .env file
# This will look for .env in the parent directory from where the app is running
load_dotenv(dotenv_path='../.env')

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
    
    # Access environment variables to display GitHub info if needed
    github_username = os.getenv('GITHUB_USERNAME', 'your-username')
    repo_name = os.getenv('REPO_NAME', 'your-repo-name')
    github_pages_url = os.getenv('GITHUB_PAGES_URL', f'https://{github_username}.github.io/{repo_name}')
    
    return render_template('index.html', 
                          layers=layers, 
                          chapters=chapters,
                          github_username=github_username,
                          repo_name=repo_name,
                          github_pages_url=github_pages_url)

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

#!/usr/bin/env python3
import os
import shutil
import sys
from jinja2 import Environment, FileSystemLoader
from app import app

def generate_static_site():
    """
    Generate a static version of the Flask site for GitHub Pages deployment
    """
    print("Generating static site for GitHub Pages...")
    
    # Create output directory
    output_dir = "gh-pages"
    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)
    os.makedirs(output_dir)
    
    # Create svg directory
    svg_dir = os.path.join(output_dir, "svg")
    os.makedirs(svg_dir)
    
    # Copy SVG files from both possible locations
    svg_sources = [
        os.path.join("static", "svg"),  # House_Code/static/svg
        os.path.join("..", "_svg_assets")  # Parent repo's _svg_assets
    ]
    
    svg_files_copied = []
    
    for svg_source in svg_sources:
        if os.path.exists(svg_source):
            for filename in os.listdir(svg_source):
                if filename.endswith(".svg"):
                    src_path = os.path.join(svg_source, filename)
                    dest_path = os.path.join(svg_dir, filename)
                    shutil.copy2(src_path, dest_path)
                    svg_files_copied.append(filename)
                    print(f"Copied SVG: {filename}")
    
    # Get data from Flask app
    # These are same data structures used in app.py to render the template
    layers = [
        {"id": "environment-layer", "name": "Environment", "default": True},
        {"id": "house-structure", "name": "House Structure", "default": True},
        {"id": "html-tags-layer", "name": "HTML Tags", "default": False},
        {"id": "structure-layer", "name": "HTML Structure", "default": False},
        {"id": "css-design-layer", "name": "CSS Design", "default": False},
        {"id": "interactive-layer", "name": "JavaScript Interactivity", "default": False},
        {"id": "systems-layer", "name": "Backend Systems", "default": False}
    ]
    
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
    
    # Check if we need to create any missing SVG placeholder files
    required_svg_files = []
    for layer in layers:
        required_svg_files.append(f"{layer['id']}.svg")
    
    # Create placeholders for any missing SVG files
    for svg_file in required_svg_files:
        if svg_file not in svg_files_copied:
            layer_name = svg_file.replace('.svg', '').replace('-', ' ').title()
            create_placeholder_svg(svg_dir, svg_file, layer_name)
            print(f"Created placeholder for: {svg_file}")
    
    # Get environment variables for GitHub info
    github_username = os.getenv('GITHUB_USERNAME', 'TortoiseWolfe')
    repo_name = os.getenv('REPO_NAME', 'The_House_that_Code_Built')
    github_pages_url = os.getenv('GITHUB_PAGES_URL', f'https://{github_username}.github.io/{repo_name}')
    
    # Prepare template data
    template_data = {
        'layers': layers,
        'chapters': chapters,
        'github_username': github_username,
        'repo_name': repo_name,
        'github_pages_url': github_pages_url
    }
    
    # Set up Jinja2 environment
    env = Environment(loader=FileSystemLoader('templates'))
    template = env.get_template('index.html')
    
    # Render template with data
    output = template.render(**template_data)
    
    # Write rendered template to index.html
    with open(os.path.join(output_dir, 'index.html'), 'w') as f:
        f.write(output)
    
    print(f"Static site generated in {output_dir}/")
    print(f"SVG files: {len(svg_files_copied)} copied, {len(required_svg_files) - len(svg_files_copied)} placeholders created")

def create_placeholder_svg(directory, filename, layer_name):
    """Create a placeholder SVG file for missing layers"""
    svg_content = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 600">
  <rect width="800" height="600" fill="none" stroke="#ccc" stroke-width="1"/>
  <text x="400" y="300" font-family="Arial" font-size="24" text-anchor="middle" fill="#999">
    {layer_name} (Placeholder)
  </text>
</svg>'''
    
    with open(os.path.join(directory, filename), 'w') as f:
        f.write(svg_content)

if __name__ == '__main__':
    generate_static_site()
#!/usr/bin/env python3
import os
import shutil
import sys
from jinja2 import Environment, FileSystemLoader

# Don't import from app.py as it might not work in GitHub Actions
# from app import app

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
    
    # Create output directories
    svg_dir = os.path.join(output_dir, "svg")
    os.makedirs(svg_dir)
    
    # Create static directory for assets like preview images
    static_dir = os.path.join(output_dir, "static")
    os.makedirs(static_dir)
    
    # Copy SVG files from both possible locations
    # Make paths more robust for GitHub Actions
    current_dir = os.path.dirname(os.path.abspath(__file__))
    svg_sources = [
        os.path.join(current_dir, "static", "svg"),  # House_Code/static/svg
        os.path.join(current_dir, "..", "_svg_assets")  # Parent repo's _svg_assets
    ]
    
    print(f"Checking SVG sources: {svg_sources}")
    
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
    
    # Set up Jinja2 environment with absolute path
    templates_dir = os.path.join(current_dir, 'templates')
    print(f"Looking for templates in: {templates_dir}")
    
    if not os.path.exists(templates_dir):
        print("ERROR: Templates directory not found!")
        print(f"Current directory: {current_dir}")
        print(f"Files in current directory: {os.listdir(current_dir)}")
        raise FileNotFoundError(f"Templates directory not found at {templates_dir}")
        
    env = Environment(loader=FileSystemLoader(templates_dir))
    template = env.get_template('index.html')
    
    # Render template with data
    output = template.render(**template_data)
    
    # Fix SVG paths to be relative instead of absolute for GitHub Pages
    # Change `/svg/layer-name.svg` to `svg/layer-name.svg` (without leading slash)
    output = output.replace('svgObject.data = `/svg/', 'svgObject.data = `svg/')
    
    # Add base tag for better path resolution on GitHub Pages
    # Insert it right after the <head> tag
    base_tag = f'<base href="{github_pages_url}/">'
    output = output.replace('<head>', '<head>\n  ' + base_tag)
    
    # Write rendered template to index.html
    with open(os.path.join(output_dir, 'index.html'), 'w') as f:
        f.write(output)
        
    print("Fixed SVG paths in rendered HTML to be relative for GitHub Pages compatibility")
    
    # Create a preview image for social media
    print("Creating preview image for social media metadata...")
    preview_image_path = os.path.join(static_dir, "house-preview.png")
    create_preview_image(preview_image_path)
    
    # Fix og:image path in HTML
    output_html_path = os.path.join(output_dir, 'index.html')
    with open(output_html_path, 'r') as f:
        html_content = f.read()
    
    # Update og:image and twitter:image to use relative paths
    html_content = html_content.replace('content="{{ github_pages_url }}/static/', 'content="static/')
    
    with open(output_html_path, 'w') as f:
        f.write(html_content)
    
    print(f"Static site generated in {output_dir}/")
    print(f"SVG files: {len(svg_files_copied)} copied, {len(required_svg_files) - len(svg_files_copied)} placeholders created")
    print(f"Preview image created at {preview_image_path}")

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
        
def create_preview_image(output_path):
    """Create a preview image for social media cards"""
    # Create a simple PNG with house preview for social media
    # This is a basic SVG that will be saved as house-preview.png
    preview_svg = '''<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="630" viewBox="0 0 1200 630">
  <!-- Background -->
  <rect width="1200" height="630" fill="#4CAF50" />
  
  <!-- House shape -->
  <polygon points="600,100 300,350 900,350" fill="#f5deb3" stroke="#333" stroke-width="4" />
  <rect x="350" y="350" width="500" height="300" fill="#f5deb3" stroke="#333" stroke-width="4" />
  <rect x="525" y="500" width="150" height="150" fill="#8B4513" stroke="#333" stroke-width="2" />
  <circle cx="650" cy="575" r="10" fill="#FFD700" />
  
  <!-- Title -->
  <text x="600" y="80" font-family="Arial" font-size="48" text-anchor="middle" fill="#fff" font-weight="bold">The House that Code Built</text>
  
  <!-- Info text -->
  <text x="600" y="580" font-family="Arial" font-size="32" text-anchor="middle" fill="#fff">Interactive Web Development Visualization</text>
</svg>'''

    # Write the SVG to a temporary file
    temp_svg_path = output_path.replace('.png', '.svg')
    with open(temp_svg_path, 'w') as f:
        f.write(preview_svg)
    
    # Convert SVG to PNG using a simple text file
    # Since we can't rely on having convert or other tools in GitHub Actions
    with open(output_path, 'w') as f:
        f.write("Preview image for social media")
    
    print(f"Created preview image placeholder at {output_path}")
    # In a real scenario, you'd use a library like cairosvg or wand to convert SVG to PNG
    # But for simplicity, we're just creating a text file for now

if __name__ == '__main__':
    try:
        print("Starting static site generation...")
        generate_static_site()
        print("Static site generation completed successfully!")
    except Exception as e:
        print(f"ERROR: Static site generation failed: {str(e)}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
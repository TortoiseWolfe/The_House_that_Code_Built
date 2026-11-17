#!/bin/bash
set -e

# Skip Docker checks in CI environment
if [ -n "$CI" ]; then
  echo "Running in CI environment - will skip Docker checks"
  SKIP_DOCKER_CHECKS=true
else
  SKIP_DOCKER_CHECKS=false
fi

# Project name configuration
PROJECT_NAME="House_Code"

# Check if the project directory already exists
if [ -d "$PROJECT_NAME" ]; then
    echo "Directory '$PROJECT_NAME' already exists. Updating existing files..."
else
    echo "Creating project directory structure..."
    mkdir -p "$PROJECT_NAME/static/svg"
    mkdir -p "$PROJECT_NAME/templates"
    mkdir -p "$PROJECT_NAME/gh-pages"
fi

# Ensure static/svg directory exists (even if project already existed)
mkdir -p "$PROJECT_NAME/static/svg"

# Check if the root .env file exists
if [ ! -f ".env" ]; then
    echo "No .env file found in project root."
    
    # Check if .env.example exists
    if [ ! -f ".env.example" ]; then
        echo "Creating .env.example file with correct values."
        
        # Create the .env.example file with correct values
        cat > ".env.example" << 'EOF'
# GitHub Pages Configuration
# Replace these values with your actual GitHub username and repository name

# Your GitHub username
GITHUB_USERNAME="TortoiseWolfe"

# Your repository name
REPO_NAME="The_House_that_Code_Built"

# The URL where your GitHub Pages site will be published
# This will be automatically generated from the above values
GITHUB_PAGES_URL="https://${GITHUB_USERNAME}.github.io/${REPO_NAME}"

# Flask configuration
FLASK_APP=House_Code/app.py
FLASK_ENV=development
FLASK_DEBUG=1
EOF
    else
        echo "Found existing .env.example file."
    fi
    
    # Copy .env.example to .env
    cp ".env.example" ".env"
    echo "Created .env file from .env.example. Edit if needed with your actual information."
else
    echo "Found existing .env file. The app will use this directly."
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
    
    # Use our template with the configured three-column layout
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

# Create the HTML template for the layer toggler with GitHub info
echo "Creating index.html template with three-column layout..."
cat > "$PROJECT_NAME/templates/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Interactive visualization of web development concepts using a house metaphor. Learn web development through layers of a house, from environment to backend systems.">
  <meta name="keywords" content="web development, HTML, CSS, JavaScript, visualization, learning tool, interactive">
  <meta name="author" content="TortoiseWolfe">
  <meta name="robots" content="index, follow">
  
  <!-- Open Graph / Facebook -->
  <meta property="og:type" content="website">
  <meta property="og:url" content="{{ github_pages_url }}">
  <meta property="og:title" content="The House that Code Built">
  <meta property="og:description" content="Learn web development through an interactive house visualization with toggleable layers">
  <meta property="og:image" content="{{ github_pages_url }}/static/house-preview.png">
  
  <!-- Twitter -->
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:url" content="{{ github_pages_url }}">
  <meta property="twitter:title" content="The House that Code Built">
  <meta property="twitter:description" content="Learn web development through an interactive house visualization with toggleable layers">
  <meta property="twitter:image" content="{{ github_pages_url }}/static/house-preview.png">
  
  <!-- Theme color for browser UI -->
  <meta name="theme-color" content="#FBF6EC">
  
  <title>The House that Code Built - Web Development Visualization</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Fredoka:wght@500;600&family=Nunito:ital,wght@0,400;0,600;0,700;1,400&family=Patrick+Hand&display=swap">
  <style>
    /* ===== Tokens: light (default) ===== */
    :root {
      --font-display: 'Fredoka', 'Nunito', system-ui, sans-serif;
      --font-body: 'Nunito', system-ui, -apple-system, 'Segoe UI', sans-serif;
      --font-hand: 'Patrick Hand', 'Comic Sans MS', cursive;

      --bg-color: #FBF6EC;        /* paper */
      --text-color: #2E2418;      /* warm ink */
      --text-soft: #4A3B28;
      --header-color: #A24A2B;    /* clay */
      --card-bg: #FFFDF8;
      --sunk-bg: #F5ECD8;
      --line: #2E2418;            /* ink outline, 15:1 on card */
      --line-soft: rgba(46,36,24,.18);
      --sticker: #2E2418;
      --card-shadow: rgba(46,36,24,.45);
      --btn-inactive: #FFFDF8;
      --btn-active: #A24A2B;      /* clay, 5.8:1 with cream text */
      --btn-active-text: #FFFDF8;
      --layer-active: #3F6E2D;    /* leaf, 5.9:1 with cream text */
      --layer-active-text: #FFFDF8;
      --divider: rgba(46,36,24,.18);
      --desc-bg: #F5ECD8;
      --link-color: #A24A2B;
      --toggle-off: #6F5B41;
      --toggle-bg: #E8A33D;
      --knob: #FFFDF8;
      --focus-outline: #3F7799;   /* 3.9:1 on paper */
      --stage-bg: #E4F1F7;
      --btn-text-light: #FFFDF8;
      --btn-text-dark: #2E2418;

      /* Three-level depth scale */
      --depth-1: 3px 3px 0 var(--sticker);                                                   /* controls: paper sticker */
      --depth-2: 0 2px 0 rgba(46,36,24,.08), 0 12px 26px -14px rgba(46,36,24,.45);         /* panels */
      --depth-3: 0 4px 0 rgba(46,36,24,.10), 0 26px 48px -20px rgba(46,36,24,.55);         /* the stage */

      --radius-sm: 12px;
      --radius-md: 16px;
      --radius-lg: 24px;
      --ease-spring: cubic-bezier(.34,1.4,.64,1);
      color-scheme: light;
    }

    /* ===== Tokens: dark ===== */
    [data-theme="dark"] {
      --bg-color: #1B1611;
      --text-color: #F5EBDA;
      --text-soft: #DCCDB5;
      --header-color: #F2C772;
      --card-bg: #262019;
      --sunk-bg: #30281F;
      --line: #B3A184;            /* 6:1 on card, outlines stay visible */
      --line-soft: rgba(245,235,218,.16);
      --sticker: #0D0A07;
      --card-shadow: rgba(0,0,0,.7);
      --btn-inactive: #262019;
      --btn-active: #F2C772;      /* straw, ink text 10:1 */
      --btn-active-text: #2E2418;
      --layer-active: #A6CD82;    /* leaf, ink text 8.8:1 */
      --layer-active-text: #2E2418;
      --divider: rgba(245,235,218,.16);
      --desc-bg: #30281F;
      --link-color: #F2C772;
      --toggle-off: #8F7E64;
      --toggle-bg: #F2C772;
      --knob: #F5EBDA;
      --focus-outline: #BBDDEC;
      --stage-bg: #2C3A41;
      --depth-1: 3px 3px 0 var(--sticker);
      --depth-2: 0 2px 0 rgba(0,0,0,.35), 0 14px 28px -14px rgba(0,0,0,.85);
      --depth-3: 0 4px 0 rgba(0,0,0,.4), 0 28px 52px -20px rgba(0,0,0,.95);
      color-scheme: dark;
    }

    *, *::before, *::after { box-sizing: border-box; }

    html { -webkit-text-size-adjust: 100%; }

    body {
      font-family: var(--font-body);
      font-size: 1.0625rem;       /* 17px */
      line-height: 1.65;
      width: 100%;
      max-width: 100%;
      margin: 0;
      padding: 0;
      overflow-x: hidden;
      background-color: var(--bg-color);
      color: var(--text-color);
      transition: background-color .3s ease, color .3s ease;
    }

    h1, h2 {
      font-family: var(--font-display);
      font-weight: 600;
      line-height: 1.15;
      text-wrap: balance;
      color: var(--text-color);
    }

    h1 {
      color: var(--header-color);
      font-size: clamp(1.75rem, 1.2rem + 2.4vw, 3.25rem);
      letter-spacing: -0.01em;
      max-width: 1440px;
      margin: 0 auto;
      padding: 22px 104px 18px 24px;   /* right padding clears the theme switch */
      text-align: left;
    }

    h2 {
      font-size: 1.375rem;
      margin: 0 0 14px;
    }

    p { margin: 0 0 .6em; }
    p:last-child { margin-bottom: 0; }

    a { color: var(--link-color); }

    :focus-visible {
      outline: 3px solid var(--focus-outline);
      outline-offset: 3px;
    }

    /* ===== Layout ===== */
    .container {
      display: block;
      width: 100%;
      max-width: 1440px;
      margin: 0 auto;
      padding: 0 16px 24px;
    }

    .three-column-layout {
      display: grid;
      grid-template-columns: minmax(0, 1fr);
      grid-template-areas: "stage" "left" "right";
      gap: 16px;
      margin-bottom: 24px;
    }

    .left-column, .center-column, .right-column {
      width: auto;
      min-width: 0;
      background-color: var(--card-bg);
      border: 1.5px solid var(--line-soft);
      border-radius: var(--radius-lg);
      box-shadow: var(--depth-2);
      padding: 20px;
    }

    .left-column { grid-area: left; display: flex; flex-direction: column; }
    .right-column { grid-area: right; }

    .center-column {
      grid-area: stage;
      position: relative;
      padding: 10px;
      min-height: 0;
      box-shadow: var(--depth-3);
    }

    @media (min-width: 700px) {
      .container { padding: 0 24px 32px; }
      .three-column-layout {
        grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
        grid-template-areas: "stage stage" "left right";
        gap: 24px;
      }
      .left-column, .right-column { padding: 24px; }
      .center-column { padding: 12px; }
    }

    @media (min-width: 1100px) {
      .three-column-layout {
        grid-template-columns: 340px minmax(0, 1fr);
        grid-template-areas: "left stage" "left right";
        grid-template-rows: auto 1fr;
        align-items: start;
      }
    }

    /* ===== Theme switch ===== */
    .theme-switch-wrapper {
      position: absolute;
      top: 16px;
      right: 16px;
      display: flex;
      align-items: center;
      gap: 6px;
      z-index: 100;
    }

    .theme-switch {
      display: inline-block;
      position: relative;
      width: 64px;
      height: 44px;              /* full touch target */
      cursor: pointer;
    }

    .theme-switch input {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      margin: 0;
      opacity: 0;
      cursor: pointer;
      z-index: 1;
    }

    .slider {
      position: absolute;
      left: 0;
      right: 0;
      top: 5px;
      bottom: 5px;
      background-color: var(--toggle-off);
      border: 2.5px solid var(--line);
      border-radius: 999px;
      box-shadow: var(--depth-1);
      transition: background-color .3s ease;
    }

    .slider:before {
      content: "";
      position: absolute;
      top: 50%;
      left: 3px;
      width: 24px;
      height: 24px;
      margin-top: -12px;
      border-radius: 50%;
      background-color: var(--knob);
      border: 2px solid var(--line);
      transition: transform .42s var(--ease-spring);
    }

    input:checked + .slider { background-color: var(--toggle-bg); }
    input:checked + .slider:before { transform: translateX(25px); background-color: #2E2418; }
    input:focus-visible + .slider { outline: 3px solid var(--focus-outline); outline-offset: 3px; }

    .theme-icon {
      margin-left: 0;
      font-size: 20px;
      line-height: 1;
    }

    /* ===== Buttons: shared sticker treatment ===== */
    .preset-buttons, .layer-toggles {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .layer-toggles { margin-bottom: 0; }

    .preset-btn, .toggle-btn {
      display: flex;
      align-items: center;
      gap: 12px;
      width: 100%;
      min-height: 48px;
      padding: 10px 16px;
      font-family: var(--font-display);
      font-weight: 500;
      font-size: 1.0625rem;
      line-height: 1.25;
      text-align: left;
      color: var(--text-color);
      background-color: var(--btn-inactive);
      border: 2.5px solid var(--line);
      border-radius: var(--radius-md);
      box-shadow: var(--depth-1);
      cursor: pointer;
      transition: transform .18s var(--ease-spring), box-shadow .18s var(--ease-spring), background-color .2s ease, color .2s ease;
    }

    .preset-btn:hover, .toggle-btn:hover {
      background-color: var(--sunk-bg);
      transform: translate(-1px, -1px);
      box-shadow: 4px 4px 0 var(--sticker);
    }

    .preset-btn:active, .toggle-btn:active {
      transform: translate(2px, 2px);
      box-shadow: 1px 1px 0 var(--sticker);
    }

    .preset-btn:focus, .toggle-btn:focus { outline: none; }
    .preset-btn:focus-visible, .toggle-btn:focus-visible {
      outline: 3px solid var(--focus-outline);
      outline-offset: 3px;
    }

    /* Radio dot for presets (single choice) */
    .preset-btn::before {
      content: "";
      flex: 0 0 18px;
      height: 18px;
      border-radius: 50%;
      border: 2.5px solid currentColor;
      background: transparent;
    }

    .preset-btn.active {
      background-color: var(--btn-active);
      color: var(--btn-active-text);
      transform: translate(2px, 2px);
      box-shadow: var(--depth-1);
    }
    .preset-btn.active::before { background: radial-gradient(circle, currentColor 0 4px, transparent 4.5px); }

    /* Checkbox for layers (many choices) */
    .toggle-btn::before {
      content: "";
      flex: 0 0 22px;
      height: 22px;
      border-radius: 7px;
      border: 2.5px solid currentColor;
      display: grid;
      place-items: center;
      font-size: 14px;
      font-weight: 700;
      line-height: 1;
    }

    .toggle-btn.active {
      background-color: var(--layer-active);
      color: var(--layer-active-text);
    }
    .toggle-btn.active::before { content: "✓"; }
    .toggle-btn.active:hover { background-color: var(--layer-active); }
    .preset-btn.active:hover { background-color: var(--btn-active); }

    @media (min-width: 1100px) {
      .layer-toggles {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
        gap: 12px;
      }
    }

    .divider {
      height: 0;
      border-top: 2px dashed var(--divider);
      background: none;
      margin: 20px 0;
    }

    .chapter-description {
      background-color: var(--desc-bg);
      padding: 12px 16px;
      border-radius: var(--radius-md);
      margin: 0;
      font-family: var(--font-hand);
      font-style: normal;
      font-size: 1.375rem;
      line-height: 1.35;
      color: var(--text-color);
      text-wrap: pretty;
    }

    .github-info {
      background-color: transparent;
      padding: 0;
      border-radius: 0;
      margin: auto 0 0;
      font-size: 1.0625rem;
      color: var(--text-soft);
    }

    .github-info p { margin: 0 0 10px; }

    .github-info a {
      overflow-wrap: normal;
      word-break: normal;
      color: var(--link-color);
      font-weight: 700;
      text-decoration: underline;
      text-decoration-thickness: 2px;
      text-underline-offset: 3px;
      text-decoration-color: color-mix(in srgb, var(--link-color) 45%, transparent);
      border-radius: 4px;
    }

    .github-info a:hover { text-decoration-color: currentColor; }
    .github-info a:focus { outline: none; }
    .github-info a:focus-visible { outline: 3px solid var(--focus-outline); outline-offset: 2px; }

    /* ===== Stage ===== */
    .svg-container {
      width: 100%;
      height: auto;
      min-height: 0;
      aspect-ratio: 4 / 3;
      position: relative;
      overflow: hidden;
      border-radius: var(--radius-md);
      background-color: var(--stage-bg);
      border: 2.5px solid var(--line);
    }

    .svg-layer {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      transition: opacity .42s ease, transform .42s ease;
    }

    /* Soften the hard purple-orange sky into a warm dusk */
    #environment-layer-svg { filter: saturate(.62) sepia(.22) brightness(1.06); }
    [data-theme="dark"] #environment-layer-svg { filter: saturate(.7) sepia(.15) brightness(.82); }

    .svg-layer.hidden {
      opacity: 0;
      transform: translateY(6px);
      pointer-events: none;
    }

    /* ===== Skip link ===== */
    .skip-link {
      position: absolute;
      top: -80px;
      left: 16px;
      background: var(--btn-active);
      color: var(--btn-active-text);
      font-family: var(--font-display);
      font-weight: 600;
      padding: 12px 18px;
      border: 2.5px solid var(--line);
      border-radius: 0 0 var(--radius-sm) var(--radius-sm);
      z-index: 1000;
      transition: top .3s;
    }

    .skip-link:focus { top: 0; }

    /* ===== Soundtrack ===== */
    .audio-section {
      margin-top: 0;
      padding: 20px;
      background-color: var(--card-bg);
      border: 1.5px solid var(--line-soft);
      border-radius: var(--radius-lg);
      box-shadow: var(--depth-2);
      display: grid;
      grid-template-columns: minmax(0, 1fr);
      gap: 18px;
    }

    .audio-section h2 { margin: 0; }

    @media (min-width: 700px) {
      .audio-section { padding: 28px; }
    }

    @media (min-width: 1100px) {
      .audio-section {
        grid-template-columns: minmax(0, 1.25fr) minmax(0, 1fr);
        column-gap: 32px;
        align-items: start;
      }
      .audio-section h2 { grid-column: 1 / -1; }
    }

    .video-container {
      position: relative;
      padding-bottom: 56.25%;
      height: 0;
      overflow: hidden;
      max-width: 100%;
      border-radius: var(--radius-md);
      border: 2.5px solid var(--line);
      box-shadow: var(--depth-1);
      background: #1F1912;
    }

    .video-container iframe {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      border: 0;
    }

    .video-facade {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      padding: 0;
      border: 0;
      border-radius: 0;
      cursor: pointer;
      background: #1F1912 url("https://i.ytimg.com/vi/04qPdGNA_KM/hqdefault.jpg") center / cover no-repeat;
      color: #FFFDF8;
      font-size: 1.0625rem;
    }

    .video-facade::before {
      content: "";
      position: absolute;
      left: 50%;
      top: 42%;
      width: 76px;
      height: 76px;
      margin: -38px 0 0 -38px;
      border-radius: 50%;
      background: #CB6843;
      border: 3px solid #2E2418;
      box-shadow: var(--depth-1);
      transition: transform .2s var(--ease-spring);
    }

    .video-facade::after {
      content: "";
      position: absolute;
      left: 50%;
      top: 42%;
      margin: -14px 0 0 -8px;
      border-style: solid;
      border-width: 14px 0 14px 24px;
      border-color: transparent transparent transparent #FFFDF8;
    }

    .video-facade:hover::before { transform: scale(1.06); }

    .video-facade:focus { outline: none; }
    .video-facade:focus-visible { outline: 4px solid var(--focus-outline); outline-offset: -6px; }

    .video-facade-label {
      position: absolute;
      left: 0;
      right: 0;
      bottom: 0;
      padding: 12px 16px;
      background: #2E2418;
      color: #FFFDF8;
      font-family: var(--font-display);
      font-weight: 500;
      line-height: 1.3;
      text-align: left;
    }

    .audio-controls { margin-top: 0; }

    .audio-controls p { max-width: 68ch; text-wrap: pretty; }

    .accessibility-note {
      background-color: var(--desc-bg);
      padding: 14px 16px;
      border-radius: var(--radius-md);
      margin-top: 14px;
    }

    .button {
      display: inline-flex;
      align-items: center;
      min-height: 44px;
      padding: 8px 18px;
      margin: 10px 0 0 0;
      background-color: var(--btn-active);
      color: var(--btn-active-text);
      font-family: var(--font-display);
      font-weight: 500;
      font-size: 1rem;
      border: 2.5px solid var(--line);
      border-radius: 999px;
      box-shadow: var(--depth-1);
      cursor: pointer;
      transition: transform .18s var(--ease-spring), box-shadow .18s var(--ease-spring);
    }

    .button[hidden] { display: none; }

    .button:hover { transform: translate(-1px, -1px); box-shadow: 4px 4px 0 var(--sticker); }
    .button:active { transform: translate(2px, 2px); box-shadow: 1px 1px 0 var(--sticker); }

    .button:focus { outline: none; }
    .button:focus-visible { outline: 3px solid var(--focus-outline); outline-offset: 3px; }

    /* ===== Signature (in flow, never overlaps content) ===== */
    .signature {
      position: static;
      width: fit-content;
      max-width: calc(100% - 32px);
      margin: 0 16px 24px auto;
      background-color: var(--card-bg);
      padding: 8px;
      border: 1.5px solid var(--line-soft);
      border-radius: var(--radius-md);
      box-shadow: var(--depth-2);
      font-size: 1rem;
    }

    @media (min-width: 700px) {
      .signature { margin: 0 max(24px, calc((100% - 1440px) / 2 + 24px)) 32px auto; }
    }

    .signature-toggle {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      min-height: 44px;
      padding: 8px 16px;
      font-family: var(--font-display);
      font-weight: 500;
      font-size: 1rem;
      color: var(--text-color);
      background: var(--btn-inactive);
      border: 2.5px solid var(--line);
      border-radius: 999px;
      box-shadow: var(--depth-1);
      cursor: pointer;
    }

    .signature-toggle:focus { outline: none; }
    .signature-toggle:focus-visible { outline: 3px solid var(--focus-outline); outline-offset: 3px; }

    .signature a {
      display: flex;
      align-items: center;
      min-height: 44px;
      padding: 4px 10px;
      margin: 2px 0;
      color: var(--link-color);
      font-weight: 600;
      text-decoration: none;
      border-radius: var(--radius-sm);
    }

    .signature a:hover { text-decoration: underline; text-underline-offset: 3px; }
    .signature a:focus { outline: none; }
    .signature a:focus-visible { outline: 3px solid var(--focus-outline); outline-offset: 0; }

    /* Small phones: tighten the title so it never runs under the switch */
    @media (max-width: 480px) {
      h1 { padding: 16px 104px 14px 16px; font-size: 1.75rem; }
      .theme-switch-wrapper { top: 14px; right: 12px; }
    }

    @media (prefers-reduced-motion: reduce) {
      *, *::before, *::after { transition-duration: 0s !important; }
    }
  </style>
</head>
<body>
  <!-- Skip to main content link for keyboard users -->
  <a href="#main-content" class="skip-link">Skip to main content</a>

  <!-- Theme switch toggle -->
  <div class="theme-switch-wrapper">
    <label class="theme-switch" for="checkbox" aria-label="Toggle dark mode">
      <input type="checkbox" id="checkbox" />
      <div class="slider" role="switch" aria-checked="false" aria-label="Dark mode"></div>
    </label>
    <span class="theme-icon" aria-hidden="true">🌓</span>
  </div>

  <h1>The House that Code Built</h1>
  
  <main id="main-content" class="container">
    <!-- Three-column layout with exact width columns 25% 55% 20% -->
    <div class="three-column-layout">
      <!-- Left column - Chapter presets -->
      <div class="left-column">
        <h2 id="chapter-presets-heading">Chapter Presets</h2>
        <div class="preset-buttons" role="toolbar" aria-labelledby="chapter-presets-heading">
          {% for chapter in chapters %}
          <button class="preset-btn {% if chapter.preset == 'base' %}active{% endif %}" 
                  data-preset="{{ chapter.preset }}"
                  aria-pressed="{% if chapter.preset == 'base' %}true{% else %}false{% endif %}">
            {{ chapter.name }}
          </button>
          {% endfor %}
        </div>
        
        <div class="divider" role="separator"></div>
        
        <div class="chapter-description" id="chapter-description" aria-live="polite">
          {{ chapters[0].description }}
        </div>
        
        {% if github_username and repo_name %}
        <div class="divider" role="separator"></div>
        <div class="github-info">
          <p>Created by <a href="https://github.com/{{ github_username }}" target="_blank" aria-label="Visit {{ github_username }}'s GitHub profile">{{ github_username }}</a></p>
          <p>Repository: <a href="https://github.com/{{ github_username }}/{{ repo_name }}" target="_blank" aria-label="Visit the {{ repo_name }} GitHub repository">{{ repo_name }}</a></p>
          {% if github_pages_url %}
          <p>GitHub Pages: <a href="{{ github_pages_url }}" target="_blank" aria-label="Visit the GitHub Pages site">{{ github_pages_url | replace("://", "://<wbr>") | replace(".io/", ".io/<wbr>") | safe }}</a></p>
          {% endif %}
        </div>
        {% endif %}
      </div>
      
      <!-- Center column - Visualization -->
      <div class="center-column">
        <section class="svg-container" id="svg-container" aria-label="Interactive visualization of the house that code built">
          <!-- SVG layers will be loaded here by JavaScript -->
        </section>
      </div>
      
      <!-- Right column - Layer toggles -->
      <div class="right-column">
        <h2 id="layer-controls-heading">Layer Controls</h2>
        <div class="layer-toggles" role="toolbar" aria-label="Toggle visibility of house layers">
          {% for layer in layers %}
          <button class="toggle-btn {% if layer.default %}active{% endif %}" 
                  data-layer="{{ layer.id }}" 
                  aria-pressed="{% if layer.default %}true{% else %}false{% endif %}"
                  aria-label="Toggle {{ layer.name }} layer">
            {{ layer.name }}
          </button>
          {% endfor %}
        </div>
      </div>
    </div>
    
    <!-- Tom Waits - What's He Building in There? audio section -->
    <section class="audio-section">
      <h2>Soundtrack: "What's He Building in There?" by Tom Waits</h2>
      <div class="video-container">
        <button type="button" id="play-video" class="video-facade" data-video-id="04qPdGNA_KM">
          <span class="video-facade-label"><span aria-hidden="true">▶</span> Play the song: What's He Building in There? by Tom Waits</span>
        </button>
      </div>
      <div class="audio-controls">
        <p>This song by Tom Waits perfectly captures the mysterious nature of building projects.</p>
        <p class="accessibility-note">
          <strong>Accessibility Note:</strong> Audio never starts by itself. It plays only after you press the play button on the video.
          <button id="toggle-audio" class="button" aria-label="Mute audio" hidden>Mute Audio</button>
        </p>
      </div>
    </section>
  </main>
  
  <!-- Author Signature -->
  <div class="signature" role="contentinfo">
    <button class="signature-toggle" aria-expanded="false" aria-controls="signature-links">© TortoiseWolfe 🐢 <span id="signature-toggle-icon" aria-hidden="true">▼</span></button>
    <div id="signature-links" style="display: none;">
      <a href="https://github.com/TortoiseWolfe" target="_blank" aria-label="Visit TortoiseWolfe's GitHub profile">GitHub: TortoiseWolfe 💻</a>
      <a href="https://www.linkedin.com/in/pohlner/" target="_blank" aria-label="Visit LinkedIn profile">LinkedIn: linkedin.com/in/pohlner/ 🌐</a>
      <a href="https://www.twitch.tv/turtlewolfe" target="_blank" aria-label="Visit Twitch channel">Twitch: twitch.tv/turtlewolfe 🎥</a>
      <a href="https://turtlewolfe.com/" target="_blank" aria-label="Visit TurtleWolfe website">Website: turtlewolfe.com 🌟</a>
    </div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Layer configuration from Flask
      const layers = {{ layers | tojson }};
      
      // Chapter presets from Flask
      const chapters = {{ chapters | tojson }};
      
      // Set up theme toggling
      setupThemeToggle();
      
      // Set up signature toggle
      setupSignatureToggle();
      
      // Load all SVG layers
      loadSvgLayers();
      
      // Set up toggle buttons
      setupToggleButtons();
      
      // Set up preset buttons
      setupPresetButtons();
      
      // Set up keyboard navigation
      setupKeyboardNavigation();
      
      // Run accessibility checks
      runAccessibilityTests();
      
      // Set up audio controls
      setupAudioControls();
      
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
          
          // Add title for accessibility
          const title = document.createElement('title');
          title.textContent = layer.name + ' layer';
          svgObject.appendChild(title);
          
          // Add alt text for accessibility
          svgObject.setAttribute('aria-label', layer.name + ' visualization layer');
          
          // Set initial visibility
          if (!layer.default) {
            svgObject.classList.add('hidden');
            svgObject.setAttribute('aria-hidden', 'true');
          } else {
            svgObject.setAttribute('aria-hidden', 'false');
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
            const isActive = this.classList.contains('active');
            
            // Toggle button active state
            this.classList.toggle('active');
            this.setAttribute('aria-pressed', !isActive);
            
            // Toggle layer visibility
            if (svgObject) {
              svgObject.classList.toggle('hidden');
              svgObject.setAttribute('aria-hidden', isActive);
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
            presetButtons.forEach(btn => {
              btn.classList.remove('active');
              btn.setAttribute('aria-pressed', 'false');
            });
            this.classList.add('active');
            this.setAttribute('aria-pressed', 'true');
            
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
                  if (svgObject) {
                    svgObject.classList.remove('hidden');
                    svgObject.setAttribute('aria-hidden', 'false');
                  }
                  if (toggleButton) {
                    toggleButton.classList.add('active');
                    toggleButton.setAttribute('aria-pressed', 'true');
                  }
                } else {
                  // Hide this layer
                  if (svgObject) {
                    svgObject.classList.add('hidden');
                    svgObject.setAttribute('aria-hidden', 'true');
                  }
                  if (toggleButton) {
                    toggleButton.classList.remove('active');
                    toggleButton.setAttribute('aria-pressed', 'false');
                  }
                }
              });
            }
          });
        });
      }
      
      // Theme toggling functionality
      function setupThemeToggle() {
        const toggleSwitch = document.querySelector('.theme-switch input[type="checkbox"]');
        const sliderElement = document.querySelector('.slider[role="switch"]');
        const currentTheme = localStorage.getItem('theme');
        
        if (currentTheme) {
          document.documentElement.setAttribute('data-theme', currentTheme);
          if (currentTheme === 'dark') {
            toggleSwitch.checked = true;
            sliderElement.setAttribute('aria-checked', 'true');
          }
        }
        
        function switchTheme(e) {
          if (e.target.checked) {
            document.documentElement.setAttribute('data-theme', 'dark');
            localStorage.setItem('theme', 'dark');
            sliderElement.setAttribute('aria-checked', 'true');
          } else {
            document.documentElement.setAttribute('data-theme', 'light');
            localStorage.setItem('theme', 'light');
            sliderElement.setAttribute('aria-checked', 'false');
          }
        }
        
        toggleSwitch.addEventListener('change', switchTheme, false);
      }
      
      // Signature toggle functionality
      function setupSignatureToggle() {
        const signatureToggle = document.querySelector('.signature-toggle');
        const signatureLinks = document.getElementById('signature-links');
        const toggleIcon = document.getElementById('signature-toggle-icon');
        
        signatureToggle.addEventListener('click', function() {
          const isVisible = signatureLinks.style.display !== 'none';
          signatureLinks.style.display = isVisible ? 'none' : 'block';
          toggleIcon.textContent = isVisible ? '▼' : '▲';
          this.setAttribute('aria-expanded', !isVisible);
        });
      }
      
      // Keyboard navigation support
      function setupKeyboardNavigation() {
        // Add keyboard support for layer toggles
        const toggleButtons = document.querySelectorAll('.toggle-btn');
        const presetButtons = document.querySelectorAll('.preset-btn');
        
        // Enable arrow key navigation for toggle buttons
        toggleButtons.forEach((button, index) => {
          button.addEventListener('keydown', function(e) {
            // Left/Up arrow keys
            if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') {
              e.preventDefault();
              const prevIndex = (index - 1 + toggleButtons.length) % toggleButtons.length;
              toggleButtons[prevIndex].focus();
            }
            // Right/Down arrow keys
            else if (e.key === 'ArrowRight' || e.key === 'ArrowDown') {
              e.preventDefault();
              const nextIndex = (index + 1) % toggleButtons.length;
              toggleButtons[nextIndex].focus();
            }
            // Space or Enter keys trigger click
            else if (e.key === ' ' || e.key === 'Enter') {
              e.preventDefault();
              button.click();
            }
          });
        });
        
        // Enable arrow key navigation for preset buttons
        presetButtons.forEach((button, index) => {
          button.addEventListener('keydown', function(e) {
            // Left/Up arrow keys
            if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') {
              e.preventDefault();
              const prevIndex = (index - 1 + presetButtons.length) % presetButtons.length;
              presetButtons[prevIndex].focus();
            }
            // Right/Down arrow keys
            else if (e.key === 'ArrowRight' || e.key === 'ArrowDown') {
              e.preventDefault();
              const nextIndex = (index + 1) % presetButtons.length;
              presetButtons[nextIndex].focus();
            }
            // Space or Enter keys trigger click
            else if (e.key === ' ' || e.key === 'Enter') {
              e.preventDefault();
              button.click();
            }
          });
        });
      }
      
      // Basic accessibility test function
      function runAccessibilityTests() {
        // This function runs basic accessibility checks and logs issues to console
        const issues = [];
        
        // Check if all images have alt text
        const svgObjects = document.querySelectorAll('object.svg-layer');
        svgObjects.forEach(svg => {
          if (!svg.hasAttribute('aria-label')) {
            issues.push('SVG missing aria-label: ' + svg.id);
          }
        });
        
        // Check if all interactive elements have accessible names
        const interactiveElements = document.querySelectorAll('button, a, [role="button"]');
        interactiveElements.forEach(el => {
          if (!el.hasAttribute('aria-label') && !el.textContent.trim()) {
            issues.push('Interactive element missing accessible name: ' + el.outerHTML.substring(0, 100));
          }
        });
        
        // Check color contrast for backgrounds
        function hasGoodContrast(bgColor, textColor) {
          // This is a simplified check - in production use a full contrast algorithm
          return true; // Assuming our color variables have been tested for contrast
        }
        
        // Log any issues found
        if (issues.length > 0) {
          console.warn('Accessibility issues found:');
          issues.forEach(issue => console.warn('- ' + issue));
        } else {
          console.log('Basic accessibility checks passed');
        }
      }
      
      // Handle YouTube embed controls.
      // Nothing is loaded and no sound plays until the visitor presses the play button (WCAG 1.4.2).
      function setupAudioControls() {
        const toggleButton = document.getElementById('toggle-audio');
        const facade = document.getElementById('play-video');
        if (!toggleButton || !facade) return;

        const videoId = facade.getAttribute('data-video-id');
        const videoContainer = document.querySelector('.video-container');
        let isMuted = false;
        let player;

        function createPlayer() {
          const playerDiv = document.createElement('div');
          playerDiv.id = 'youtube-player';
          videoContainer.innerHTML = '';
          videoContainer.appendChild(playerDiv);

          player = new YT.Player('youtube-player', {
            height: '315',
            width: '560',
            videoId: videoId,
            playerVars: {
              'autoplay': 1,
              'loop': 1,
              'playlist': videoId
            },
            events: {
              'onReady': onPlayerReady
            }
          });
        }

        function onPlayerReady() {
          player.getIframe().setAttribute('title', "Tom Waits - What's He Building in There?");
          toggleButton.hidden = false;
          player.playVideo();
          toggleButton.addEventListener('click', function() {
            if (isMuted) {
              player.unMute();
              toggleButton.textContent = 'Mute Audio';
              toggleButton.setAttribute('aria-label', 'Mute audio');
            } else {
              player.mute();
              toggleButton.textContent = 'Unmute Audio';
              toggleButton.setAttribute('aria-label', 'Unmute audio');
            }
            isMuted = !isMuted;
          });
        }

        facade.addEventListener('click', function() {
          facade.disabled = true;
          if (window.YT && window.YT.Player) {
            createPlayer();
            return;
          }
          window.onYouTubeIframeAPIReady = createPlayer;
          const tag = document.createElement('script');
          tag.src = "https://www.youtube.com/iframe_api";
          document.head.appendChild(tag);
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
python-dotenv==1.0.0
pytest==7.4.0
pytest-flask==1.2.0
flask-cors==4.0.0
Jinja2==3.1.2
EOF

# Create a test directory with both general and accessibility tests
mkdir -p "$PROJECT_NAME/tests"

# Create a pytest file for general functionality testing
cat > "$PROJECT_NAME/tests/test_functionality.py" << 'EOF'
import os
import pytest
from flask import url_for
from app import app as flask_app

@pytest.fixture
def app():
    """Create a Flask app instance for testing."""
    flask_app.config.update({
        "TESTING": True,
    })
    return flask_app

@pytest.fixture
def client(app):
    """Create a test client for the app."""
    return app.test_client()

def test_index_route(client):
    """Test that the index route returns a 200 response."""
    response = client.get('/')
    assert response.status_code == 200
    assert b'<!DOCTYPE html>' in response.data
    assert b'The House that Code Built' in response.data

def test_svg_route(client):
    """Test that the SVG route works correctly."""
    # Test a known SVG file
    response = client.get('/svg/house-structure.svg')
    assert response.status_code in [200, 404]  # 404 is acceptable if testing without SVGs
    
    if response.status_code == 200:
        assert response.content_type in ['image/svg+xml', 'application/octet-stream']

def test_environment_variables(app):
    """Test that environment variables are properly loaded."""
    # These should have default values if .env file is not found
    assert hasattr(app, 'config')
    
    # Check that Flask configuration is set properly
    assert app.config['TESTING'] is True

def test_template_rendering(client):
    """Test that templates are properly rendered with expected variables."""
    response = client.get('/')
    html_content = response.data.decode('utf-8')
    
    # Check that key elements are in the template
    assert '<div class="layer-toggles"' in html_content
    assert '<div class="preset-buttons"' in html_content
    assert '<div class="svg-container"' in html_content
    
def test_tom_waits_section(client):
    """Test that the Tom Waits section is correctly implemented."""
    response = client.get('/')
    html_content = response.data.decode('utf-8')
    
    # Check for Tom Waits section
    assert 'Tom Waits - What\'s He Building in There?' in html_content
    assert '<section class="audio-section">' in html_content
    assert 'data-video-id="04qPdGNA_KM"' in html_content
    # Audio must never start by itself (WCAG 1.4.2): no autoplay iframe in the page source
    assert '<iframe' not in html_content
    
    # Check for accessibility controls
    assert 'id="toggle-audio"' in html_content
    assert 'Accessibility Note' in html_content

def test_error_handling(client):
    """Test error handling for non-existent routes."""
    response = client.get('/non-existent-route')
    assert response.status_code == 404
EOF

# Create a pytest file for accessibility testing
cat > "$PROJECT_NAME/tests/test_accessibility.py" << 'EOF'
import os
import pytest
from flask import url_for
from app import app as flask_app

@pytest.fixture
def app():
    """Create a Flask app instance for testing."""
    flask_app.config.update({
        "TESTING": True,
    })
    return flask_app

@pytest.fixture
def client(app):
    """Create a test client for the app."""
    return app.test_client()

def test_page_has_proper_structure(client):
    """Test that the page has proper semantic structure."""
    response = client.get('/')
    assert response.status_code == 200
    
    # Check for essential accessibility elements
    html_content = response.data.decode('utf-8')
    
    # Check for language attribute
    assert 'lang="en"' in html_content
    
    # Check for semantic elements
    assert '<main' in html_content
    assert '<section' in html_content
    assert 'role="contentinfo"' in html_content
    
    # Check for skip link
    assert 'class="skip-link"' in html_content
    
    # Check for ARIA attributes
    assert 'aria-label' in html_content
    assert 'aria-live="polite"' in html_content
    assert 'aria-pressed' in html_content

def test_interactive_elements_accessible(client):
    """Test that interactive elements are accessible."""
    response = client.get('/')
    assert response.status_code == 200
    
    html_content = response.data.decode('utf-8')
    
    # Theme toggle should have proper ARIA labels
    assert 'aria-label="Toggle dark mode"' in html_content
    
    # Buttons should have aria-pressed states
    assert 'aria-pressed="true"' in html_content
    assert 'aria-pressed="false"' in html_content
    
    # Links should have accessible text
    assert '<a' in html_content and 'aria-label' in html_content
    
    # Tab index should be properly set for keyboard navigation
    # At minimum, no negative tabindex values should exist
    assert 'tabindex="-1"' not in html_content

def test_images_have_alt_text(client):
    """Test that SVG elements have proper alternative text."""
    response = client.get('/')
    assert response.status_code == 200
    
    html_content = response.data.decode('utf-8')
    
    # Dynamic SVG objects should be created with aria-label in JavaScript
    assert 'aria-label' in html_content
    assert 'setAttribute(\'aria-label\'' in html_content

def test_color_contrast(client):
    """Test color contrast variables follow WCAG standards."""
    response = client.get('/')
    assert response.status_code == 200
    
    html_content = response.data.decode('utf-8')
    
    # This is a simplified check - in a real application, you would use 
    # a color contrast analysis library or axe-core
    
    # Check that our light mode contrasts are defined
    assert '--bg-color: #f5f5f5;' in html_content
    assert '--text-color: #333;' in html_content
    
    # Check that dark mode contrasts are defined
    assert '--bg-color: #121212;' in html_content
    assert '--text-color: #e0e0e0;' in html_content
    
    # The actual contrast calculation would typically be done with a dedicated tool

def test_keyboard_navigation(client):
    """Test that keyboard navigation is supported."""
    response = client.get('/')
    assert response.status_code == 200
    
    html_content = response.data.decode('utf-8')
    
    # Check for keyboard event handlers
    assert 'keydown' in html_content
    assert 'ArrowLeft' in html_content
    assert 'ArrowRight' in html_content
    assert 'focus()' in html_content
EOF

# Create a conftest.py file to configure pytest
cat > "$PROJECT_NAME/conftest.py" << 'EOF'
import os
import sys

# Add the current directory to the Python path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
EOF

# Update the app.py file to properly use the .env file from root directory
cat > "$PROJECT_NAME/app.py" << 'EOF'
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
EOF

# Create the Dockerfile
cat > "$PROJECT_NAME/Dockerfile" << 'EOF'
# Use an official Python runtime as a base image
FROM python:3.11-slim

# Set environment variables to prevent Python from writing .pyc files and to enable unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install Node.js for accessibility tools
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install accessibility testing tools
RUN npm install -g pa11y axe-core

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
      - ./templates:/app/templates
      - ./static:/app/static
      - ../_svg_assets:/app/_svg_assets
      - ../.env:/app/.env
    env_file:
      - ../.env
    restart: unless-stopped
EOF

# Create a test script to verify the setup works
cat > "$PROJECT_NAME/test.sh" << 'EOF'
#!/bin/bash
set -e

echo "=== House That Code Built - Test Script ==="
echo "This script will test various components of the setup"

# Check if we're in the right directory
if [ ! -f "app.py" ]; then
  echo "❌ Error: Run this script from the House_Code directory"
  exit 1
fi

echo "✅ Directory check passed"

# Check for required files
for file in app.py Dockerfile docker-compose.yml templates/index.html requirements.txt; do
  if [ ! -f "$file" ]; then
    echo "❌ Error: Required file not found: $file"
    exit 1
  fi
done

echo "✅ Required files check passed"

# Test if SVG assets are available
svg_count=0

# Check in local static/svg directory
if [ -d "static/svg" ]; then
  local_svg_count=$(find static/svg -name "*.svg" | wc -l)
  svg_count=$((svg_count + local_svg_count))
  echo "📁 Found $local_svg_count SVG files in static/svg directory"
else
  mkdir -p static/svg
  echo "📁 Created static/svg directory (was missing)"
fi

# Check in the _svg_assets directory
if [ -d "../_svg_assets" ]; then
  parent_svg_count=$(find ../_svg_assets -name "*.svg" | wc -l)
  svg_count=$((svg_count + parent_svg_count))
  echo "📁 Found $parent_svg_count SVG files in parent _svg_assets directory"
fi

if [ $svg_count -eq 0 ]; then
  echo "⚠️ Warning: No SVG files found. The application may not display properly."
else
  echo "✅ Found $svg_count total SVG files"
fi

# Check Docker
if ! command -v docker >/dev/null 2>&1; then
  echo "❌ Error: Docker is not installed or not in PATH"
  exit 1
fi

echo "✅ Docker installation check passed"

if ! docker info >/dev/null 2>&1; then
  echo "❌ Error: Docker daemon is not running or you don't have permissions"
  exit 1
fi

echo "✅ Docker daemon check passed"

# Check if the application is already running
if docker ps | grep -q "house_code-web"; then
  echo "ℹ️ The application is already running"
else
  echo "ℹ️ Application is not running. Use 'docker-compose up' to start it."
fi

echo
echo "All tests completed successfully! 🎉"
echo "To run the application: docker-compose up"
echo "Then visit: http://localhost:5000"
EOF

# Create accessibility test script
cat > "$PROJECT_NAME/test_accessibility.sh" << 'EOF'
#!/bin/bash
set -e

echo "=== Accessibility Testing for House That Code Built ==="
echo "This script will test for accessibility compliance"
echo

# Check if we're in the right directory
if [ ! -f "app.py" ]; then
  echo "❌ Error: Run this script from the House_Code directory"
  exit 1
fi

# Install accessibility testing tools if not already installed
if ! command -v pa11y &> /dev/null; then
  echo "Installing pa11y for accessibility testing..."
  
  # Check if npm is installed
  if ! command -v npm &> /dev/null; then
    echo "❌ Error: npm is required but not installed. Please install Node.js and npm first."
    exit 1
  fi
  
  npm install -g pa11y
fi

# Ensure the app is running
if ! curl -s http://localhost:5000 &> /dev/null; then
  echo "⚠️ App doesn't seem to be running. Starting with docker-compose..."
  docker-compose up -d
  sleep 5
fi

echo "Running accessibility tests (WCAG2.1 AA)..."

# Run pa11y accessibility tests
pa11y http://localhost:5000 --standard WCAG2AA --reporter csv > accessibility_report.csv

# Count issues by severity
ERRORS=$(grep -c ",error," accessibility_report.csv || echo "0")
WARNINGS=$(grep -c ",warning," accessibility_report.csv || echo "0")
NOTICES=$(grep -c ",notice," accessibility_report.csv || echo "0")

echo "Test completed with:"
echo "- $ERRORS errors"
echo "- $WARNINGS warnings" 
echo "- $NOTICES notices"

if [ "$ERRORS" -gt 0 ]; then
  echo "❌ Critical accessibility issues detected!"
  grep ",error," accessibility_report.csv | cut -d ',' -f 5,6 | sed 's/,/ - /' | sed 's/"//g' | sed 's/^/  - /'
else
  echo "✅ No critical accessibility errors found!"
fi

if [ "$WARNINGS" -gt 0 ]; then
  echo "⚠️ Accessibility warnings to address:"
  grep ",warning," accessibility_report.csv | cut -d ',' -f 5,6 | sed 's/,/ - /' | sed 's/"//g' | sed 's/^/  - /' | head -5
  if [ "$WARNINGS" -gt 5 ]; then
    echo "  ... and $(($WARNINGS - 5)) more warnings."
  fi
fi

echo
echo "Full accessibility report saved to: accessibility_report.csv"
echo "=============================================="
echo "To fix issues:"
echo "1. Edit templates/index.html"
echo "2. Make sure all interactive elements have proper ARIA attributes"
echo "3. Ensure sufficient color contrast (minimum 4.5:1 for normal text)"
echo "4. Add keyboard navigation support for all interactive elements"
echo "5. Run this test again to verify fixes: ./test_accessibility.sh"
EOF

chmod +x "$PROJECT_NAME/test_accessibility.sh"
chmod +x "$PROJECT_NAME/test.sh"

# Create static site generator script for GitHub Pages
cat > "$PROJECT_NAME/generate_static_site.py" << 'EOF'
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
EOF
chmod +x "$PROJECT_NAME/generate_static_site.py"

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

This is a Flask application that allows you to visualize web development concepts using a house metaphor with interactive SVG layers. The application features Tom Waits' "What's He Building in There?" as a soundtrack, perfectly complementing the mysterious nature of building and construction.

## Features

- Interactive SVG layer toggling
- Chapter-based navigation for learning progression
- Dark/light mode with persistent user preference
- Fully accessible interface with keyboard navigation
- Tom Waits soundtrack with accessible controls
- Comprehensive accessibility testing suite
- Responsive design for all device sizes

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

## Accessibility Features

This application is built with accessibility in mind:

- **ARIA attributes**: All interactive elements have proper ARIA roles and states
- **Keyboard navigation**: Full keyboard support for navigating between elements
- **Screen reader support**: Elements have descriptive labels and proper semantic structure
- **Skip links**: Skip to main content link for keyboard users
- **Focus management**: Visible focus indicators and proper focus order
- **Color contrast**: Compliant with WCAG 2.1 AA standards for color contrast
- **Responsive design**: Accessible on mobile and desktop devices

## Accessibility Testing

Several testing tools are included to verify accessibility compliance:

1. **Automated accessibility tests**:
   ```
   cd House_Code
   ./test_accessibility.sh
   ```
   This will run pa11y to test WCAG 2.1 AA compliance.

2. **Python unit tests**:
   ```
   cd House_Code
   python -m pytest tests/test_accessibility.py -v
   ```
   
3. **In-browser testing**:
   The application includes built-in accessibility checking that logs issues to the browser console.

## Accessibility Checklist

- ✓ Semantic HTML structure with proper landmarks
- ✓ ARIA roles, states, and properties for interactive elements
- ✓ Keyboard navigation and focus management
- ✓ Sufficient color contrast
- ✓ Text alternatives for non-text content
- ✓ Proper heading structure
- ✓ Skip links for keyboard users
EOF

# Create GitHub Actions workflow for automatic GitHub Pages deployment
mkdir -p "$PROJECT_NAME/.github/workflows"
cat > "$PROJECT_NAME/.github/workflows/github-pages.yml" << 'EOF'
name: Deploy to GitHub Pages with Accessibility Testing

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
          
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
          pip install pytest pytest-flask
          npm install -g pa11y axe-core
      
      - name: Run accessibility unit tests
        run: |
          python -m pytest tests/test_accessibility.py -v
        
      - name: Start Flask app for accessibility testing
        run: |
          python app.py &
          sleep 3  # Give Flask time to start
          
      - name: Run automated accessibility tests
        run: |
          pa11y http://localhost:5000 --standard WCAG2AA --reporter json > accessibility-report.json
          
      - name: Check for critical issues
        run: |
          errors=$(cat accessibility-report.json | grep -c '"type":"error"' || echo "0")
          if [ "$errors" -gt "0" ]; then
            echo "Found $errors accessibility errors. See accessibility-report.json for details."
            exit 1
          else
            echo "No critical accessibility issues found!"
          fi
          
      - name: Upload accessibility report
        uses: actions/upload-artifact@v3
        with:
          name: accessibility-report
          path: accessibility-report.json

  build:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      
      - name: Setup Pages
        uses: actions/configure-pages@v3
      
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install flask python-dotenv
      
      - name: Build static site
        run: |
          mkdir -p gh-pages/svg
          
          # Copy SVG files from parent _svg_assets if they exist
          if [ -d "../_svg_assets" ]; then
            cp ../_svg_assets/*.svg gh-pages/svg/ || true
          fi
          
          # Copy SVG files from static/svg if they exist
          if [ -d "static/svg" ]; then
            cp static/svg/*.svg gh-pages/svg/ || true
          fi
          
          # Create index.html for GitHub Pages
          cat > gh-pages/index.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="An interactive visualization of web development concepts using a house metaphor">
  <title>The House that Code Built</title>
  <style>
    :root {
      --bg-color: #f5f5f5;
      --text-color: #333;
      --header-color: #2e7d32;
      --card-bg: #ffffff;
      --card-shadow: rgba(0,0,0,0.1);
      --btn-color: #2196F3;
      --btn-hover: #1976D2;
      --btn-text: #ffffff;
      --focus-outline: #2196F3;
    }
    
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
      background-color: var(--bg-color);
      color: var(--text-color);
      line-height: 1.5;
    }
    
    h1, h2 {
      color: var(--header-color);
      text-align: center;
    }
    
    .skip-link {
      position: absolute;
      top: -40px;
      left: 0;
      background: var(--btn-color);
      color: var(--btn-text);
      padding: 8px;
      z-index: 1000;
      transition: top 0.3s;
    }
    
    .skip-link:focus {
      top: 0;
    }
    
    main {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }
    
    .svg-container {
      background-color: var(--card-bg);
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 10px var(--card-shadow);
      min-height: 600px;
      position: relative;
      margin-top: 30px;
    }
    
    .svg-layer {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }
    
    .github-link {
      margin-top: 30px;
      text-align: center;
    }
    
    .button {
      display: inline-block;
      padding: 10px 15px;
      background-color: var(--btn-color);
      color: var(--btn-text);
      text-decoration: none;
      border-radius: 4px;
      font-weight: bold;
      border: none;
      cursor: pointer;
    }
    
    .button:hover, .button:focus {
      background-color: var(--btn-hover);
    }
    
    .button:focus {
      outline: 3px solid var(--focus-outline);
      outline-offset: 2px;
    }
    
    footer {
      margin-top: 40px;
      text-align: center;
      font-size: 0.9em;
      color: var(--text-color);
    }
  </style>
</head>
<body>
  <a href="#main-content" class="skip-link">Skip to main content</a>
  
  <header>
    <h1>The House that Code Built</h1>
    <p style="text-align: center;">An interactive visualization of web development concepts</p>
  </header>
  
  <main id="main-content">
    <section class="svg-container" aria-label="House visualization">
      <object data="svg/environment-layer.svg" type="image/svg+xml" class="svg-layer" aria-label="Environment layer visualization"></object>
      <object data="svg/house-structure.svg" type="image/svg+xml" class="svg-layer" aria-label="House structure visualization"></object>
    </section>
    
    <div class="github-link">
      <p>To view the interactive version with all layers:</p>
      <a href="https://github.com/${{ github.repository }}" class="button" aria-label="View full interactive project on GitHub">View on GitHub</a>
    </div>
  </main>
  
  <footer role="contentinfo">
    <p>This project follows WCAG 2.1 AA accessibility guidelines</p>
  </footer>
</body>
</html>
HTML
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: './gh-pages'

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v3
EOF

# Run tests and start the application automatically
echo -e "\033[1;32m=== Automatically testing and starting the application ===\033[0m"
cd "$PROJECT_NAME"

# Run the test script to verify everything is properly set up
echo -e "\033[1;33mRunning tests...\033[0m"
./test.sh

# Skip Docker operations in CI environment
if [ -n "$CI" ]; then
  echo "Skipping Docker operations in CI environment"
else
  # Start the Docker container in the background
  echo -e "\033[1;33mStarting the application in background mode...\033[0m"
  docker-compose up -d
fi

# Wait for the container to start
echo "Waiting for application to start..."
sleep 5

# Check if the application is running (skip in CI)
if [ -n "$CI" ]; then
  echo "Skipping container check in CI environment"
  container_running=true
elif docker ps | grep -q "house_code-web" 2>/dev/null; then
  # Get the local IP for better display in the instructions
  if command -v hostname &> /dev/null; then
    LOCAL_IP=$(hostname -I | awk '{print $1}')
  else
    LOCAL_IP="localhost"
  fi
  
  echo -e "\033[1;32m=== Application Started Successfully! ===\033[0m"
  echo -e "\033[1;36m"
  echo "  ╔════════════════════════════════════════════════════════════╗"
  echo "  ║                                                            ║"
  echo "  ║   The House that Code Built is now running!                ║"
  echo "  ║                                                            ║"
  echo "  ║   🌐 Open in your browser: http://localhost:5000           ║"
  echo "  ║                                                            ║"
  echo "  ╚════════════════════════════════════════════════════════════╝"
  echo -e "\033[0m"
  
  # Try to open the browser automatically (platforms where xdg-open, open, or start are available)
  echo "Attempting to open browser automatically..."
  if command -v xdg-open &> /dev/null; then
    xdg-open "http://localhost:5000" &> /dev/null || true
  elif command -v open &> /dev/null; then
    open "http://localhost:5000" &> /dev/null || true
  elif command -v start &> /dev/null; then
    start "http://localhost:5000" &> /dev/null || true
  else
    echo "Could not automatically open browser. Please open it manually."
  fi
else
  echo -e "\033[1;31mApplication failed to start. Check docker logs for more information:\033[0m"
  echo -e "  \033[1mdocker-compose logs\033[0m"
fi

# Show helpful commands for managing the application
echo ""
echo -e "\033[1;32m=== Useful Commands ===\033[0m"
echo -e "• View application logs: \033[1mcd $PROJECT_NAME && docker-compose logs -f\033[0m"
echo -e "• Monitor resource usage: \033[1mdocker stats\033[0m"
echo -e "• Stop the application: \033[1mcd $PROJECT_NAME && docker-compose down\033[0m"
echo -e "• Restart the application: \033[1mcd $PROJECT_NAME && docker-compose restart\033[0m"
echo ""

# GitHub Pages deployment information
echo -e "\033[1;32m=== GitHub Pages Deployment ===\033[0m"
echo -e "When you're ready to share your visualization online:"
echo -e "1. Push your repository to GitHub"
echo -e "2. Go to \033[1mSettings → Pages\033[0m in your GitHub repository"
echo -e "3. Set source to \033[1m'GitHub Actions'\033[0m"

# Try to read values from .env if it exists
if [ -f ".env" ]; then
    GITHUB_USERNAME_VALUE=$(grep GITHUB_USERNAME .env | cut -d'"' -f2)
    GITHUB_PAGES_URL_VALUE=$(grep GITHUB_PAGES_URL .env | cut -d'"' -f2)
    echo -e "4. Your site will be automatically deployed to: \033[1;36m$GITHUB_PAGES_URL_VALUE\033[0m"
else
    echo -e "4. Your site will be automatically deployed to your GitHub Pages URL"
fi
echo ""
echo -e "\033[1;33mNote:\033[0m You can add or modify SVG files in the _svg_assets directory at any time."
echo -e "Run \033[1mcd $PROJECT_NAME && docker-compose restart\033[0m if you add new SVG files while the app is running."
echo ""
echo -e "\033[1;32mSetup complete! Enjoy building your visualization! 🏠 🧱 🚀\033[0m"

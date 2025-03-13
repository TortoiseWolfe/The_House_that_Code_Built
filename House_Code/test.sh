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

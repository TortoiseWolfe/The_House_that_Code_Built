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

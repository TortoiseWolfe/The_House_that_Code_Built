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
    
    # Check for three-column layout
    assert 'three-column-layout' in html_content
    assert 'class="column left-column"' in html_content
    assert 'class="column right-column"' in html_content

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

def test_layout_accessibility(client):
    """Test that the three-column layout is accessible."""
    response = client.get('/')
    assert response.status_code == 200
    
    html_content = response.data.decode('utf-8')
    
    # Check for appropriate heading structure in each column
    assert 'id="chapter-presets-heading"' in html_content
    assert 'id="layer-controls-heading"' in html_content
    
    # Check for aria-labelledby to connect headings with sections
    assert 'aria-labelledby="chapter-presets-heading"' in html_content
    assert 'aria-labelledby="layer-controls-heading"' in html_content
    
    # Check for responsive design elements
    assert 'media' in html_content and 'max-width' in html_content
    
    # Check audio section accessibility
    assert 'audio-section full-width' in html_content
    assert 'aria-label="Mute audio"' in html_content

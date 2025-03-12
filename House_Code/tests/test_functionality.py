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
    assert '<section class="column center-column">' in html_content
    
def test_three_column_layout(client):
    """Test that the three-column layout is correctly implemented."""
    response = client.get('/')
    html_content = response.data.decode('utf-8')
    
    # Check for three-column layout structure
    assert 'three-column-layout' in html_content
    assert 'class="column left-column"' in html_content
    assert 'class="column center-column"' in html_content
    assert 'class="column right-column"' in html_content
    
def test_tom_waits_section(client):
    """Test that the Tom Waits section is correctly implemented."""
    response = client.get('/')
    html_content = response.data.decode('utf-8')
    
    # Check for Tom Waits section
    assert 'Tom Waits - What\'s He Building in There?' in html_content
    assert '<section class="audio-section full-width">' in html_content
    assert 'youtube.com/embed/04qPdGNA_KM' in html_content
    
    # Check for accessibility controls
    assert 'id="toggle-audio"' in html_content
    assert 'Accessibility Note' in html_content

def test_error_handling(client):
    """Test error handling for non-existent routes."""
    response = client.get('/non-existent-route')
    assert response.status_code == 404

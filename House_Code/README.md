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

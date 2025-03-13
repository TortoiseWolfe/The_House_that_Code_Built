# CLAUDE.md - Working With FlaskFirst

## Build & Run Commands
- **Generate Project**: `bash FirstFlask.sh` - Creates House_Code directory with Flask app
- **Run App**: `cd House_Code && docker-compose up` - Start the Flask application
- **Stop App**: `cd House_Code && docker-compose down` - Stop running containers
- **View Logs**: `cd House_Code && docker-compose logs -f` - Follow container logs
- **Restart App**: `cd House_Code && docker-compose restart` - Restart after changes
- **Run Accessibility Tests**: `cd House_Code && ./test_accessibility.sh` - Test WCAG compliance
- **Run Unit Tests**: `cd House_Code && python -m pytest tests/test_accessibility.py -v` - Run unit tests
- **Check GitHub Actions**: Visit repository's Actions tab to monitor deployment status

## GitHub Pages Deployment
- **Competing Workflows Issue**: This repository currently has multiple GitHub Actions workflows that conflict with each other:
  - `Deploy Flask App to GitHub Pages` - Working workflow
  - `.github/workflows/pages.yml` - Failing workflow
  - `.github/workflows/github-pages.yml` - Newly added workflow that needs fixing
- **Recommended Actions**:
  1. Delete problematic workflows directly in GitHub web interface
  2. Navigate to repository → .github/workflows directory
  3. Delete any workflows named `pages.yml` or other competing workflows
  4. Keep only one working workflow
- **Post-Cleanup Process**:
  1. Push changes to GitHub repository's main branch
  2. GitHub Actions will automatically run the workflow
  3. The workflow builds a static version of the site
  4. Static files are deployed to the gh-pages branch
  5. Site is accessible at the GitHub Pages URL configured in .env
- **Three-Column Layout**: The deployed site maintains the exact 23%-52%-19% column proportions
- **Troubleshooting**:
  - Multiple conflicting workflows cause deployment failures
  - Check GitHub Actions tab to identify which workflow is succeeding
  - Manually remove all other workflow files through GitHub web interface
  - Exit code 127 indicates "command not found" errors in GitHub Actions
  - If columns are misaligned, check HTML structure for proper nesting of div elements

## Code Style Guidelines
- **SVG Assets**: Place SVG files in `_svg_assets/` directory with kebab-case filenames
- **Environment Variables**: Use `.env.example` as template; always use `TortoiseWolfe` for username
- **Repository Naming**: Use `The_House_that_Code_Built` as the standard repository name
- **GitHub Pages URL**: Follow format `https://TortoiseWolfe.github.io/The_House_that_Code_Built`
- **Python Imports**: Group standard library first, followed by third-party packages
- **HTML/CSS**: Follow BEM naming convention for CSS classes
- **JavaScript**: Use camelCase for variable/function names; organize code by feature
- **Error Handling**: Use try/except blocks when accessing files; provide informative fallbacks
- **Font Sizes**: Use large, child-friendly sizes (18px minimum, headings 2rem+)
- **SVG Containment**: Ensure SVG layers remain within defined container boundaries

## Layout Guidelines
- **Three-Column Structure**: Left column (presets), center column (visualization), right column (layer controls)
- **Column Proportions**: Maintain 1:3:0.7 ratio for desktop layouts (25%, 55%, 20%)
- **Left Column**: Contains chapter preset buttons stacked vertically and chapter description
- **Center Column**: Contains SVG visualization with all interactive layers
- **Right Column**: Contains layer toggle buttons stacked vertically
- **Responsive Breakpoints**: 
  - 1024px: Switch to two-column layout (controls on sides, visualization spanning full height)
  - 768px: Switch to single-column layout (stacked vertically)
- **Visualization Container**: Must include proper containment for SVG layers
- **Button Sizing**: Ensure all buttons are large enough for easy interaction (minimum 44px touch target)
- **Font Scaling**: All text should remain readable at 200% zoom level
- **Tom Waits Section**: Must remain below the three-column layout

## CRITICAL: Layout Implementation Testing
- **Focus on Source Files**: Only modify FirstFlask.sh - NEVER waste time modifying disposable container output
- **Correct Build Process**: Ensure all changes are made to the template files in FirstFlask.sh, not running containers
- **Debug Three-Column Layout**: When three columns aren't appearing:
  1. Examine CSS in FirstFlask.sh: Check display property (grid vs flex vs table)
  2. Verify column classes/identifiers are consistent between CSS and HTML
  3. Look for conflicting styles that might override column definitions
  4. Ensure container width is set appropriately (either 100% or fixed width)
  5. Check parent containers for any constraining styles
  6. **CRITICAL**: Check HTML structure for unclosed or mismatched div tags
  7. Check for accidental extra closing tags that break the column structure
  8. Set explicit widths for columns in percentages that total 100% or less
- **Verify Production Output**: Always test final result at http://localhost:5000 after full rebuild
- **HTML/CSS Consistency**: Use one layout approach consistently (either grid OR flex OR table)
- **Clean Rebuild**: Always use full rebuild process for layout changes (rm -rf House_Code && bash FirstFlask.sh)
- **Docker Volume Configuration**: When templates aren't loading, try mounting the entire app directory with `./:/app`
- **Flexbox Best Practices**:
  1. Use both `width` and `flex` properties: `width: 25%; flex: 0 0 25%;`
  2. Avoid overflowing with `box-sizing: border-box;` on columns
  3. Set explicit margins that don't exceed remaining width (e.g., if columns total 100%, use no margins)

## Accessibility Guidelines
- **ARIA Attributes**: All interactive elements must have proper ARIA roles and states
- **Keyboard Navigation**: All interactive elements must be keyboard accessible
- **Color Contrast**: Maintain a minimum contrast ratio of 4.5:1 for normal text, 3:1 for large text
- **Focus Management**: All interactive elements must have a visible focus state
- **Screen Reader Support**: Use proper semantic HTML and provide text alternatives
- **SVG Elements**: Add title elements and aria-label attributes to SVGs
- **Testing**: Run accessibility tests before each commit to ensure compliance

## Static Site Generation
- **Process**: GitHub Actions generates static HTML/CSS from Flask templates
- **SVG Handling**: SVG files are copied from _svg_assets to the static site
- **Build Directory**: Files are placed in gh-pages directory before deployment
- **Simplified Interface**: Static site shows environment and house structure layers
- **GitHub Link**: Static site includes a link back to the repository for the full interactive version

## UI Component Organization
- **Chapter Presets**: Blue buttons placed in left column, stacked vertically
- **Layer Controls**: Green toggle buttons placed in right column, stacked vertically
- **Chapter Description**: Located in left column below preset buttons
- **GitHub Info**: Located at bottom of left column
- **Theme Toggle**: Located in top-right corner of page
- **Signature**: Fixed position in bottom-right corner

## Notes
- Docker environment is configured to mount SVG assets and environment variables
- GitHub Actions automatically handles deployment to GitHub Pages on push
- GitHub Actions includes automated accessibility testing with pa11y
- All SVG files should include proper title and desc elements for accessibility
- Template files are mounted as volume for easier development
- Tom Waits audio section should always remain below the main columns
- FirstFlask.sh now includes CI environment detection for improved GitHub Actions compatibility

# Last Updated: Wed Mar 13 04:15:00 PM EDT 2025
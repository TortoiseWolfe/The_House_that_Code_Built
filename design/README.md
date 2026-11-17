# The House that Code Built: design source

These files came out of Claude Design (claude.ai/design) on 16 November 2026 and are kept here unmodified.

- Claude Design project: https://claude.ai/design/p/0a147938-3aeb-4636-bc19-ef727d68e9c0
- Design system used: "Hat, Coat & Boots" (the `_ds/` folder is its export)
- Model shown in the project: Opus 5.5
- Input: a written brief plus the page's HTML and CSS, pasted as text (modernise the look, keep the picture-book warmth and the house illustration, keep every control, WCAG 2.1 AA, readable at 390 px)

| File | What it is |
|---|---|
| `house-that-code-built.html` | The redesigned page that Claude Design made. Its `<style>` block is what the live page now uses. |
| `House Redesign Board.dc.html` | The Claude Design canvas that shows the redesign. |
| `support.js` | Claude Design's canvas runtime, needed to open the canvas. |
| `_ds/` | The "Hat, Coat & Boots" design system: tokens, styles and notes. |

## How it reached the live page

The stylesheet, the web fonts and a theme colour were copied into `House_Code/templates/index.html` and into the matching copy inside `FirstFlask.sh`. The script and markup were left alone, so every control and behaviour is the same as before. A few changes were made after the port:

- The shadows at rest use one three-step scale.
- The left column ends at its own content instead of stretching to the height of the picture, which removed an empty band.
- A soft line break was added to the GitHub Pages link so it wraps cleanly on a phone.

If the look changes again, re-run Claude Design and compare against the files here, not against the live page.

# Hat, Coat & Boots — Design System

A warm, hand-built design system for **Hat, Coat & Boots**, a children's picture-book
series about sustainable natural building. The conceit: a house wears the same three
things you do —

- **Hat** = the roof
- **Coat** = the walls
- **Boots** = the foundation

The signature interaction is a **layered transparency overlay** (think the acetate
pages in an old encyclopedia or a health textbook): every spread is a stack of
see-through layers that fade in and out, so the house literally builds itself as the
story is read. A single-page-app feel — narrative sits over a layered graphic that
changes with each page.

The series voice lives **somewhere between Bob Ross, Mister Rogers, and This Old
House**: gentle, encouraging, neighborly, and quietly competent about real craft.

### The series
1. **Hat, Coat & Boots** — roof, walls, foundation (this system's reference book).
2. **Water, Waste & Electricity** — rain barrels, composting toilets, solar panels, windmills *(planned)*.
3. **A Tiny House on Wheels** — build it all on a double-axle trailer, reusing ideas from books 1 & 2 *(planned)*.

---

## Sources

This system was distilled from two repositories the author provided. They are not
bundled here; explore them for deeper context when extending the system:

- **TortoiseWolfe/HatCoatAndBoots** — https://github.com/TortoiseWolfe/HatCoatAndBoots
  The book project itself (a Next.js/ScriptHammer fork). The genuinely book-specific
  material is in `knowledge/construction/` — a cradle-to-cradle design coach prompt and
  two William McDonough talk transcripts that ground the series' philosophy. *(The repo's
  README is mostly inherited ScriptHammer template boilerplate; ignore its industrial
  "silver/steel" theme — it is not this brand.)*
- **TortoiseWolfe/The_House_that_Code_Built** — https://github.com/TortoiseWolfe/The_House_that_Code_Built
  The origin of the **layered SVG overlay mechanic**: a three-column SPA (chapter presets ·
  layered illustration · layer toggles) where toggleable SVG layers explain a house. The
  reference SVGs and screenshots are copied into `assets/reference/`. We kept the *mechanic*
  and reimagined the *art* as a warm storybook instead of a blueprint.

> Reading either repo end-to-end will help an agent build more faithful artifacts.

---

## Content fundamentals

How the series talks:

- **Voice:** warm, calm, patient, encouraging. The reader is a friend, not a student.
  Gentle wonder over instruction. ("Come along and we will build one, piece by piece.")
- **Person:** second person, inclusive *we* and *you*. "Every house wears three things,
  just like you." Never corporate "users."
- **Sentence shape:** short, rhythmic, read-aloud friendly. One idea per line. Plenty of
  concrete sensory nouns (straw, stone, sunshine, rain).
- **The central metaphor is load-bearing:** roof→hat, walls→coat, foundation→boots.
  Reuse it relentlessly; it is the spine of the whole brand. ("Boots keep your feet dry.")
- **Casing:** sentence case everywhere — titles, buttons, labels. Only the wordmark and
  proper book titles use Title Case. SMALL-CAPS LABELS are reserved for tiny UI eyebrows
  (e.g. "CHAPTERS", "PEEL THE LAYERS").
- **Two registers:** the *story* voice (for kids) and a quieter *"for grown-ups"* voice
  (cradle-to-cradle, materials, technique) that appears in asides and the marketing site.
- **Emoji:** used sparingly and warmly as friendly punctuation in margin notes and
  buttons (☀️ 🐝 🏡 📖 🔨), never in body narrative. One per note, max.
- **Margin notes** carry the fun facts and encouragement, in a handwritten voice
  ("Straw bales are wonderful insulation!").
- **Avoid:** jargon, fear/scolding, hype, exclamation pile-ups, data slop. No statistics
  unless a grown-up section genuinely needs one.

Examples:
- Title: *"Boots keep your feet dry"* · Body: *"Down at the bottom we stack a footing of
  river stone. Like rubber boots in a puddle, it lifts the house up out of the wet."*
- Button: *"Start reading"*, *"Read free"*, *"Notify me"*.
- Grown-up aside: *"A building should give back like a tree: clean air, clean water,
  healthy soil."*

---

## Visual foundations

**Overall vibe** — a hand-illustrated storybook page. Warm cream "paper", chunky ink
outlines, paper-sticker buttons, and soft natural-material colors. Diagrammatic but cozy,
like a beloved how-things-work book.

- **Color** — earthy and warm. Three brand hues map to the metaphor: **Hat** = straw gold
  (`--hat-500 #E8A33D`), **Coat** = clay terracotta (`--coat-500 #CB6843`), **Boots** =
  river-stone blue (`--boots-500 #5C7480`). A living-world palette (leaf green, soft sky,
  sun yellow, a rare berry pop) sets the scene. A cradle-to-cradle pair — **bio** (green) vs
  **technical** (steel-sky) — encodes the books' material philosophy. Text is a warm
  near-black (`--ink-900 #2E2418`), never pure black. Surfaces are cream paper
  (`--paper-50`) and warm white cards (`--cloud`). Use 1–2 background tints per layout, max.
- **Type** — three roles. Display **Fredoka** (chunky, rounded) for titles, numbers and
  buttons; body **Nunito** (warm humanist sans) for narrative and UI; **Patrick Hand** for
  handwritten margin notes, overlay labels and captions. Gentle 1.25 scale, roomy line
  height (1.55) for read-aloud. *(All three are Google Fonts — see caveats.)*
- **Backgrounds** — flat warm cream, never gradients on UI chrome. The *illustration*
  itself is the imagery: layered SVGs with soft same-direction shading. No photographic
  imagery in the brand chrome.
- **The sticker affordance** — the signature. Every tappable thing (buttons, chips,
  toggles, cards) gets a **2.5px ink outline** + a **hard offset shadow** (`3px 3px 0`),
  like a paper cut-out glued to the page. On press it slides into its own shadow
  (`translate(2px,2px)` + `1px 1px 0`) — springy and satisfying for small hands.
- **Shadows** — two systems: *soft* paper-lift (`--shadow-card`) for resting surfaces, and
  *hard sticker* offsets for interactive elements. No blurry diffuse drop shadows on chrome.
- **Borders & corners** — ink outlines (`--border-ink 2.5px`), generous friendly radii
  (cards `--radius-lg 24px`, buttons fully pill). Cards = warm-white fill + ink border +
  soft lift shadow, optionally with a strip of decorative "tape" on a corner.
- **The overlay system** — transparent layers on a shared 800×600 viewBox stack pixel-perfect.
  Layers cross-fade (opacity + a 6px lift) over `--dur-slow 420ms`. A base layer is *locked*
  (always on); the rest peel on and off. This is the brand's one big idea — lean into it.
- **Motion** — gentle and friendly. Soft springy presses (`--ease-spring` with a small
  overshoot), transparency cross-fades, never anything that whips or loops forever. Fully
  respects `prefers-reduced-motion` (durations collapse to 0).
- **Hover/press** — buttons keep their resting color and respond through the sticker
  shadow + position rather than color shifts; toggles fill with the brand hue when on and
  gain a `2px 2px 0` ink shadow. Focus uses a sky-blue offset ring that reads on busy art.
- **Transparency & blur** — minimal. A faint paper haze (`--overlay-scrim`) can sit over
  art behind a modal; otherwise surfaces are opaque. No glassmorphism.
- **Imagery vibe** — warm, sunlit, friendly. Greens and golds dominate; cool stone-blue
  grounds the base. Everything outlined in the same warm ink so layers feel cut from one set.

---

## Iconography

- **The mark** — `assets/brand/mark.svg`: a little house in three stacked parts (gold thatch
  hat, clay coat walls, stone boots footing) with a green living-roof sprig. Font-independent
  so it travels anywhere; pair it with the Fredoka wordmark in HTML.
- **House layers** — `assets/layers/book1/{world,boots,coat,hat}.svg`: the four transparent
  illustration layers, hand-built as friendly geometric SVG on a shared 800×600 grid. These
  ARE the iconography of the reader — replace or extend per book.
- **Glyphs** — the system uses a small set of **emoji as friendly glyphs** in buttons, chips,
  pager and margin notes (← → ✕ ★ ✓ ☀️ 🐝 🏡 📖 🔨 🥾 🎩 🌍 🔊 🔇). This is intentional and
  on-brand for a warm kids' product — used sparingly, one per element. No icon font is
  required and none is shipped.
- **No hand-rolled UI icon set** beyond the above. If a richer outline icon set is ever
  needed, choose a **rounded, friendly** family (e.g. Lucide or Phosphor at a thick stroke)
  to match the chunky ink outlines — and document the addition here. Do not mix in sharp,
  thin, or corporate icon styles.
- **Reference art** in `assets/reference/` (the original code-house SVGs + screenshots) is
  kept for provenance only — it is *not* brand art; do not ship it in deliverables.

---

## What's in here (manifest)

**Foundations**
- `styles.css` — the single entry point consumers link. `@import` lines only.
- `tokens/` — `fonts.css`, `colors.css`, `typography.css`, `spacing.css`, `effects.css`, `motion.css`.
- `foundations/*.html` — specimen cards (Colors, Type, Spacing, Brand) shown on the Design System tab.

**Components** (`window.HatCoatBootsDesignSystem_0d0e5a.*`)
- `components/core/` — `Button`, `IconButton`, `Chip`, `Badge`, `Card`, `MarginNote`, `Switch`, `ProgressDots`.
- `components/reader/` — `LayerToggle`, `OverlayStage` *(the signature layered viewer)*, `Callout` *(encyclopedia-style labels)*.
- Each has a `.d.ts` (props), a `.prompt.md` (what & when + usage), and a `*.card.html` showcase.

**UI kits** (`ui_kits/`)
- `storybook-reader/` — the flagship product: a beat-driven scrollytelling storybook. A fixed, full-screen house builds itself one transparent layer at a time as 17 narrative beats scroll past, with encyclopedia callouts, spotlights and cutaway insets (`ReaderData` · `SceneStage` · `BeatPanel` · `ReaderApp`).
- `series-site/` — the public marketing site for the series (hero w/ live OverlayStage, book shelf, how-it-works, footer).

**Templates** (`templates/`)
- `storybook-spread/` — a copy-ready book page: a layered build-it-yourself house beside editable narrative.

**Assets** (`assets/`)
- `brand/mark.svg`, `layers/book1/*.svg`, `reference/*` (provenance only).

**Skill**
- `SKILL.md` — makes this folder usable as a downloadable Agent Skill.

---

## Caveats / substitutions

- **Fonts are Google Fonts substitutes.** No brand font binaries shipped with the source
  repos, so Fredoka / Nunito / Patrick Hand are loaded via `@import` in `tokens/fonts.css`
  as the closest warm-storybook match. The DS compiler therefore reports **0 webfonts**
  (they're remote, not `@font-face` binaries). If real brand fonts exist, drop them in
  `assets/fonts/`, swap the `@import` for `@font-face`, and update `tokens/fonts.css`.
- **Illustration art is original, diagrammatic placeholder.** The four house layers are
  friendly geometric SVGs built to demonstrate the mechanic — not final published book art.
  Replace with real illustrations (same 800×600 viewBox, transparent ground) when available.

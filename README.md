# Marshall Labs Design System

A lightweight, dark-first CSS design language for Marshall Labs products. One file, no build step, no JavaScript required.

## Installation

```sh
make install
```

Installs the `/visualize` Claude Code skill to `~/.claude/skills/visualize/`. Re-run after updating `marshall-labs.css` or `index.html` to keep the skill bundle in sync.

## Usage

1. Copy `marshall-labs.css` into your project and link it.
2. Add `class="ml-page"` to `<body>`.
3. Compose with the utility classes below.

```html
<link rel="stylesheet" href="marshall-labs.css">
<body class="ml-page">
  <div class="ml-container">
    ...
  </div>
</body>
```

## Theming

Dark mode is the default. Switch themes by setting `data-theme` on `<html>` or any ancestor element.

```html
<html lang="en" data-theme="dark">   <!-- default -->
<html lang="en" data-theme="light">  <!-- light mode -->
```

You can scope a theme to a single section rather than the whole page by applying `data-theme` to any container.

## Fonts

The system uses two families loaded from Google Fonts:

| Role | Family |
|---|---|
| UI / body | Inter |
| Code / mono | JetBrains Mono |

Both are imported automatically by `marshall-labs.css`.

## Design Tokens

All tokens are CSS custom properties under the `--ml-*` namespace and are re-declared per theme.

### Color palette

| Token | Purpose |
|---|---|
| `--ml-bg` | Page background |
| `--ml-surface` | Card / panel background |
| `--ml-surface-2` | Sunken / inset surface |
| `--ml-border` | Subtle border |
| `--ml-border-strong` | Emphasized border |
| `--ml-text` | Primary text |
| `--ml-text-muted` | Secondary text |
| `--ml-text-faint` | Tertiary / disabled text |
| `--ml-accent` | Active accent (inherits from color modifiers) |

### Accent colors

Six semantic accent colors, each with a soft (low-opacity) variant for backgrounds:

`--ml-blue` · `--ml-green` · `--ml-red` · `--ml-yellow` · `--ml-purple` · `--ml-orange`

`--ml-blue-soft` · `--ml-green-soft` · … (10% opacity fills)

### Spacing & shape

| Token | Value |
|---|---|
| `--ml-gap` | `24px` (default grid/flex gap) |
| `--ml-radius` | `10px` |
| `--ml-radius-sm` | `6px` |
| `--ml-radius-lg` | `14px` |

## Class Reference

### Layout

| Class | Description |
|---|---|
| `.ml-container` | Centered content, max-width 1200px |
| `.ml-container--narrow` | Centered content, max-width 820px |
| `.ml-stack` | Vertical flex column, `24px` gap |
| `.ml-stack--sm / --lg / --xl` | Gap variants: 12 / 40 / 64px |
| `.ml-row` | Horizontal flex row, wrapping |
| `.ml-grid` | CSS grid with `--ml-gap` |
| `.ml-grid--2/3/4/5` | Fixed column count (collapses on small screens) |

### Typography

| Class | Description |
|---|---|
| `.ml-eyebrow` | Small all-caps label, accent color |
| `.ml-title` | Fluid display heading (40–72px), weight 800 |
| `.ml-title--md / --sm` | Smaller display variants |
| `.ml-lede` | Large intro paragraph, muted color |
| `.ml-heading` | Section heading, 15px weight 600 |
| `.ml-text` | Body paragraph, muted color |
| `.ml-text-strong` | Body paragraph, primary color |
| `.ml-footnote` | Small supporting text, faint color |
| `.ml-accent` | Inline accent color span |

### Color Modifiers

Apply to any element to set `--ml-accent` for itself and all descendants.

```html
<div class="ml-card ml-c-green">...</div>
```

| Class | Sets accent and text color |
|---|---|
| `.ml-c-blue/green/red/yellow/purple/orange` | Colors element and cascades accent |
| `.ml-scope-blue/green/…` | Cascades accent only — does not recolor the element itself |

### Cards

| Class | Description |
|---|---|
| `.ml-card` | Base card: surface background, border, 10px radius |
| `.ml-card--lg` | Larger padding, 14px radius |
| `.ml-card--sunken` | `surface-2` background |
| `.ml-card--accent` | Left accent border (pair with a color modifier) |
| `.ml-card--top` | Top accent border (stat cards) |
| `.ml-card--tinted` | Tinted background from current accent |
| `.ml-card__title` | Card heading in accent color |
| `.ml-card__tag` | Monospace all-caps tag line |
| `.ml-card__divider` | Horizontal rule within a card |

### Stats

| Class | Description |
|---|---|
| `.ml-stat__value` | Large metric value (42px), accent color |
| `.ml-stat__value--sm / --lg` | 32px / 56px variants |
| `.ml-stat__label` | Supporting label below the value |

### Pills & Code

| Class | Description |
|---|---|
| `.ml-pill` | Inline monospace badge |
| `.ml-pill--blue/green/red/yellow/purple` | Colored pill variants |
| `.ml-code` | Preformatted code block |
| `.ml-tok-kw / str / num / comment / fn` | Syntax token colors (inside `.ml-code`) |

### Badges

| Class | Description |
|---|---|
| `.ml-badge` | Inline status badge, bordered pill style |
| `.ml-badge--blue/green/red/yellow/purple/orange` | Colored variants |

### Alerts

| Class | Description |
|---|---|
| `.ml-alert` | Full-width alert banner, left accent border |
| `.ml-alert__title` | Bold title line inside an alert |
| Pair with `.ml-scope-{color}` | Sets accent and border color |

### Buttons

| Class | Description |
|---|---|
| `.ml-btn` | Base button |
| `.ml-btn--primary` | Filled accent button |
| `.ml-btn--ghost` | Transparent bordered button |
| `.ml-btn--sm / --lg` | Size variants |

### Form Inputs

| Class | Description |
|---|---|
| `.ml-field` | Wrapper for label + input + helper |
| `.ml-label` | Field label |
| `.ml-input` | Text input / textarea |
| `.ml-helper` | Supporting text below an input |
| `.ml-helper--error` | Error state helper text |
| `[aria-invalid="true"]` on `.ml-input` | Red border error state |

### Gradient Text

| Class | Description |
|---|---|
| `.ml-gradient` | Base class for gradient text (apply with a variant) |
| `.ml-gradient--blue-purple` | Blue → purple |
| `.ml-gradient--blue-green` | Blue → green |
| `.ml-gradient--purple-red` | Purple → red |
| `.ml-gradient--orange-red` | Orange → red |
| `.ml-gradient--yellow-orange` | Yellow → orange |
| `.ml-gradient--green-blue` | Green → blue |
| `.ml-gradient--diagonal` | Changes gradient direction to 135° |

### Data Visualization

| Class | Description |
|---|---|
| `.ml-segbar` | Segmented horizontal bar container |
| `.ml-segbar__seg` | Individual segment; set `--ml-seg-color` for fill |
| `.ml-segbar__seg--muted` | De-emphasized segment (surface-2 fill) |
| `.ml-legend` | Flex legend container |
| `.ml-legend__item` | Dot + label pair |
| `.ml-legend__dot` | Colored dot; inherits from `--ml-accent` |

### Tables

| Class | Description |
|---|---|
| `.ml-table` | Full-width, borderless table |
| `.ml-td-muted` | Muted cell text |

### Utilities

| Class | Description |
|---|---|
| `.ml-hr` | Subtle horizontal rule |
| `.ml-theme-toggle` | Fixed-position theme toggle button (SVG icon, no label text) |

## Live Reference

Open `index.html` in a browser for a full rendered component reference with code examples.

## Claude Code Skill

The `/visualize` skill generates self-contained HTML documents styled with this design system. Install it with `make install`, then invoke it in Claude Code:

```
/visualize create an article about how git works
/visualize a one-pager summarizing our Q3 metrics
```

The generated file is a single `.html` with the CSS inlined — no dependencies, works offline.

## Principles

- **Dark-first.** The dark palette is the default; light is an override.
- **Single cascade token.** `--ml-accent` flows through the tree — set it once on a container and every accent-aware child picks it up.
- **No JavaScript dependency.** Theme switching is a `data-theme` attribute change; all else is CSS.
- **`ml-*` namespace.** All classes are prefixed to avoid collisions when embedded in larger projects.

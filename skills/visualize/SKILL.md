---
description: Generate a self-contained single-page HTML document styled with the Marshall Labs design language. Use when the user invokes /visualize <prompt> to create articles, documentation, reports, explainers, or visual pitches.
---

# /visualize

Generate a single self-contained `.html` file styled with the Marshall Labs design language. The file inlines the entire CSS in a `<style>` block so it can be emailed, hosted anywhere, or opened directly with no dependencies.

## When to use

Trigger when the user types `/visualize <prompt>`. The prompt describes what to create. Examples:

- `/visualize create an article about how git works`
- `/visualize a one-pager summarizing our Q3 metrics`
- `/visualize explain the difference between TCP and UDP`
- `/visualize a pitch for a new internal tool called Pulse`

Treat the prompt as both the **subject** and the **content type** signal. Article, summary, explainer, pitch, report — pick the layout that fits.

## Bundled files

This skill ships with two files in the same directory as this SKILL.md:

- `marshall-labs.css` — the full design system stylesheet, to be inlined into every output
- `example.html` — a complete, real-world example using the design language. **This is your primary reference for how to compose pages.** Study it before generating output.

## Locating the bundled files

The skill may be installed at any of these paths, depending on how the user installed it:

- `<project>/.claude/skills/visualize/` (project-level)
- `~/.claude/skills/visualize/` (user-level)
- a plugin path under `~/.claude/plugins/`

To locate the bundle deterministically, run this from the user's CWD:

```bash
for p in \
  "$(pwd)/.claude/skills/visualize" \
  "$HOME/.claude/skills/visualize" \
  "$HOME/.claude/plugins"/*/skills/visualize ; do
  [ -f "$p/marshall-labs.css" ] && echo "$p" && break
done
```

Cache the resulting absolute path; both `marshall-labs.css` and `example.html` live inside it.

## Workflow

1. **Locate the bundle** (see above). Resolve to an absolute path.
2. **Read `example.html` from the bundle.** This is your primary reference for composition patterns — section structure, color cycling, card usage, code blocks, stat grids, hero treatments. Match its idioms.
3. **Parse the prompt.** Identify (a) the subject, (b) the content type (article / report / explainer / pitch / reference), and (c) the tone.
4. **Generate the content.** Write the actual prose, headings, data, code examples, etc. yourself. Be substantive — this is the deliverable. For articles, aim for genuine length and depth, not stub sections.
5. **Pick a layout.** Map content type → layout (see "Layouts" below).
6. **Pick a filename.** Kebab-case, 2–5 words derived from the subject (e.g., `how-git-works.html`, `q3-metrics.html`). If a file with that name already exists in CWD, suffix `-2`, `-3`, etc.
7. **Read `marshall-labs.css` from the bundle** in full so its contents can be inlined.
8. **Assemble the HTML.** Use the scaffold in "HTML scaffold" below. Paste the entire CSS file contents between the `<style>` tags.
9. **Write the file** to the user's current working directory.
10. **Report the path** as a single line. Do not paste the HTML back to the user.

## Layouts

Pick one based on content type:

| Content type | Container | Notes |
|---|---|---|
| Article / explainer / long-form | `ml-container--narrow` (820px) | Optimized for reading. Use `ml-stack--lg` between sections. |
| Report / dashboard / metrics | `ml-container` (1200px) | Use `ml-grid--N` rows of `ml-card--top` stat cards and content cards. |
| Pitch / one-pager / overview | `ml-container` | Strong hero, then 3–5 color-coded sections. |
| Reference / docs | `ml-container` | Tables, code blocks, pills. |

## HTML scaffold

Use this exact skeleton. Replace `{{TITLE}}`, `{{CONTAINER_CLASS}}`, and `{{BODY_CONTENT}}`. Paste the entire contents of `marshall-labs.css` into the `<style>` block.

```html
<!doctype html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{TITLE}}</title>
  <style>
{{PASTE marshall-labs.css HERE — the full file, unmodified}}
  </style>
</head>
<body class="ml-page">
  <div class="{{CONTAINER_CLASS}}">
    {{BODY_CONTENT}}
  </div>
</body>
</html>
```

**Theme.** Default to `data-theme="dark"` on `<html>`. If the user explicitly asks for light mode in the prompt (e.g., "make it light", "use the light theme"), set `data-theme="light"` instead. The chosen theme is baked into the file — never include a toggle button.

## Design language quick reference

Everything is prefixed `ml-`. Compose utilities; do not write custom CSS unless the design system genuinely cannot express it.

**Layout**

- `.ml-stack` (24px column), `.ml-stack--sm` (12px), `.ml-stack--lg` (40px), `.ml-stack--xl` (64px)
- `.ml-row` (wrapping flex row)
- `.ml-grid` + `.ml-grid--2/3/4/5` (auto-collapses on narrow viewports)

**Typography**

- `.ml-eyebrow` — small all-caps label in accent color. Use to label each section.
- `.ml-title` (hero, 40–72px), `.ml-title--md` (section), `.ml-title--sm` (sub-section)
- `.ml-lede` — large muted intro paragraph
- `.ml-text` — body paragraph (muted), `.ml-text-strong` — body paragraph (primary)
- `.ml-footnote` — small faint text
- `.ml-accent` — inline accent-color span (use sparingly for emphasis in titles)
- `.ml-heading` — small section heading (15px, weight 600) for inside cards

**Accent colors** (apply to any element to set its color and cascade `--ml-accent` to descendants)

- `.ml-c-blue`, `.ml-c-green`, `.ml-c-red`, `.ml-c-yellow`, `.ml-c-purple`, `.ml-c-orange`
- `.ml-scope-{color}` — cascade accent without recoloring the element itself (good for cards)

**Cards**

- `.ml-card` — base
- `.ml-card--lg` — larger padding
- `.ml-card--sunken` — recessed background
- `.ml-card--accent` — left accent border (pair with `.ml-scope-{color}`)
- `.ml-card--top` — top accent border (stat cards)
- `.ml-card--tinted` — tinted background from current accent
- `.ml-card__title` — accent-colored card heading
- `.ml-card__tag` — monospace all-caps tag inside card
- `.ml-card__divider` — horizontal rule inside card

**Stats**

- `.ml-stat__value` (42px), `.ml-stat__value--sm` (32px), `.ml-stat__value--lg` (56px)
- `.ml-stat__label` — label below the value

**Pills & code**

- `.ml-pill` — mono inline badge; pair with `--blue/green/red/yellow/purple` for color
- `<pre class="ml-code">` — code block. Inside it, use `<span class="ml-tok-kw">`, `ml-tok-str`, `ml-tok-num`, `ml-tok-comment`, `ml-tok-fn` for syntax tokens.

**Data viz**

- `.ml-segbar` containing `.ml-segbar__seg` — set `--ml-seg-color: var(--ml-blue)` inline per segment
- `.ml-legend` containing `.ml-legend__item` with `.ml-legend__dot` and label

**Tables**

- `.ml-table` — full-width borderless. Use `.ml-td-muted` on de-emphasized cells.

**Other**

- `.ml-hr` — subtle horizontal rule
- `.ml-theme-toggle` — fixed-position theme toggle (included in scaffold)

## Composition principles

These are the patterns that make output look on-brand:

- **Lead every section with an eyebrow + title pair.** `<span class="ml-eyebrow ml-c-green">01 · Section name</span>` followed by `<h2 class="ml-title ml-title--md">…</h2>` and a `<p class="ml-lede">` intro. Cycle through accent colors across sections — don't reuse the same color twice in a row.
- **Use an accent word in titles.** Wrap one word in `<span class="ml-accent">` so each title has visual focus.
- **Prefer cards for grouped content.** Lists of related items belong in `.ml-grid--N` of `.ml-card`s, not raw `<ul>`s.
- **Use `ml-pill` for inline references** to commands, file names, class names, keys (`<code class="ml-pill">git rebase</code>`).
- **Use stat cards for any numerics.** Numbers → `ml-card ml-card--top` with `ml-scope-{color}` + `ml-stat__value` + `ml-stat__label`. Always group in `ml-grid--N`.
- **Use `ml-code` blocks for code or shell.** Add token spans for syntax highlighting when it adds value.
- **Use `ml-segbar` + `ml-legend` for proportions** (any "X% / Y% / Z%" breakdown).
- **Keep `<table>` clean** — wrap with `class="ml-table"` and use `ml-td-muted` for less-important columns.
- **Open with a hero.** Eyebrow + big `ml-title` + `ml-lede`. Optionally a row of stat cards beneath it for at-a-glance signals.
- **Close with something** — a callout card, a footnote, a "what's next" list — not just a trailing paragraph.

## Don'ts

- **Don't link external CSS.** The CSS must be inlined in `<style>`. The file must work offline as a single `.html`.
- **Don't link external images.** If you need imagery, use SVG (inline) or CSS-only treatments.
- **Don't include a theme toggle.** Pick one theme (dark by default; light only if the user asks) and hardcode it via `data-theme` on `<html>`. The output is a static document.
- **Don't add JavaScript.** The output is pure HTML + CSS.
- **Don't use raw `<h1>`/`<h2>`/`<h3>` without `ml-title*` classes.** They will render with browser defaults and look wrong.
- **Don't use raw `<p>` without `ml-text` / `ml-lede` / `ml-footnote`.** Same reason.
- **Don't write custom CSS** unless the design system truly cannot express the layout. Inline `style="margin-top: 8px"` for one-off spacing is fine; new classes are not.
- **Don't fabricate facts.** For technical articles, stick to what you actually know to be true. If a topic is outside your confident knowledge, say so in the lede ("a high-level overview, not a definitive reference").
- **Don't paste the generated HTML back to the user.** Just report the file path.
- **Don't open the file** automatically — the user prefers to open it themselves.

## Filename rules

- Kebab-case, 2–5 words drawn from the prompt's subject
- Strip filler words ("create", "an", "article", "about", "the")
- Examples:
  - `/visualize create an article about how git works` → `how-git-works.html`
  - `/visualize Q3 metrics summary for the board` → `q3-metrics-summary.html`
  - `/visualize explain TCP vs UDP` → `tcp-vs-udp.html`
- If the file already exists in CWD, suffix `-2`, `-3`, etc. Use `ls` to check first.

## Example walkthrough

User: `/visualize create an article about how git works`

1. Locate the bundle (e.g., resolves to `/Users/x/.claude/skills/visualize/`).
2. Read `example.html` from the bundle to recall the design idioms.
3. Subject: how Git works. Content type: technical article / explainer. Tone: instructional.
4. Generate content. Write actual sections: "What Git tracks" (the object model: blobs, trees, commits), "The three trees" (working dir, index, HEAD), "Branches are pointers", "How merge and rebase differ", etc. Each with real prose, code examples in `ml-code`, key terms as `ml-pill`s.
5. Layout: `ml-container--narrow` for readability.
6. Filename: `how-git-works.html` (check it doesn't already exist).
7. Read `marshall-labs.css` from the bundle.
8. Assemble HTML using the scaffold. Inline the CSS. Color-code sections (blue, green, purple, yellow, orange).
9. Write file to CWD.
10. Reply with: `Wrote how-git-works.html`

That's it. Keep the response to the user terse — the HTML file is the deliverable.

## Keeping the bundle in sync

If `marshall-labs.css` or `index.html` evolves in the source project, copy the updated files into this skill folder (`example.html` is a renamed copy of `index.html`). The skill is intentionally self-contained so it can be installed anywhere; the trade-off is that the bundled snapshot is frozen until refreshed manually.

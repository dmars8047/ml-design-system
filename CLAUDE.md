# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A single-file CSS design system (`marshall-labs.css`) for Marshall Labs products. No build step, no JavaScript, no bundler. The only deliverable is `marshall-labs.css`.

`index.html` is the live reference — open it in a browser to see every component rendered with code examples alongside.

## Skills

The repo ships a `/visualize` Claude Code skill that generates self-contained HTML documents using the design system. Install it with:

```sh
make install
```

This copies `skills/visualize/SKILL.md` and `marshall-labs.css` to `~/.claude/skills/visualize/`. When `marshall-labs.css` or `index.html` changes, re-run `make install` to keep the skill bundle in sync.

## Design system conventions

All classes are prefixed `ml-` to avoid collisions when embedded in larger projects.

**Theming** is controlled by a `data-theme="dark|light"` attribute on `<html>` or any ancestor element. Dark is the default. There is no JavaScript involved — setting the attribute is enough.

**`--ml-accent`** is the single cascade token for color. Set it once on a container (via `.ml-c-{color}` or `.ml-scope-{color}`) and every accent-aware descendant inherits it. `.ml-c-{color}` recolors the element itself; `.ml-scope-{color}` cascades only.

**Token namespace:** all CSS custom properties are `--ml-*`. Defined in `:root` and overridden under `[data-theme="light"]`.

## Adding or changing components

- Work only in `marshall-labs.css`. Do not add JavaScript or external dependencies.
- New tokens go in the `:root` block (dark values) and must be mirrored in `[data-theme="light"]`.
- New classes must use the `ml-` prefix.
- After any change, verify both dark and light modes in `index.html`.

# CLAUDE.md — intermediate-agentic-ai

Workshop slide deck for an **intermediate** Agentic AI session — a follow-on to the
beginner tutorial. Presenter: Dr. Gaurav Manek, A\*STAR.

---

## Repository structure

```
slides.typ        Typst source for the compiled slide deck (the deliverable)
figures/          Generated figures (typ sources + rendered .png); .png is gitignored
media/            Images, memes, diagrams used on slides
.agents/skills/   Installed Claude Code skills (touying-author, typst-author)
.github/          Release workflow: compiles slides.typ → PDF on tag push
```

---

## Slides tech stack

Slides are written in **Typst** using the **Touying** presentation framework
(`@preview/touying:0.7.4`) with the **metropolis** theme.

Two Claude Code skills are installed to assist:

- `touying-author` — Touying-specific APIs, slide structure, animations
- `typst-author` — general Typst language reference

### Heading levels

| Level | Touying meaning |
|-------|----------------|
| `=`   | New section (shows in progress bar / outline) |
| `==`  | New slide with title |
| `---` | New slide without title |

Add `<touying:hidden>` to suppress a section from the outline/progress bar.

### Established macros (defined at top of `slides.typ`)

```typst
#let label-item(title, body) = ...   // bold label + inline body, fills grid cell height
#let gblock(body) = ...              // grey rounded block
#let lblock(body) = ...              // white block with light border
#let similar(items) = ...            // "Other examples — ..." footnote-style block
```

### Common patterns

```typst
#speaker-note[...]                   // hidden unless presenter mode
#pause                               // progressive reveal
#grid(columns: (1fr, 1fr), gutter: 1em, [...], [...])   // two-column layout
#focus-slide[Big statement here.]    // dark emphasis slide
#align(center)[#image("media/foo.jpg", height: 78%)]    // full-bleed image / meme
```

### Animation in grids

`#pause` and `#meanwhile` are processed in **source order**, not grid-position order.
In a 2×2 grid the default source order is row-major. Use `grid.cell(x:, y:)` to position
cells explicitly, then write them in the source order that matches the desired reveal
sequence. `#meanwhile` rewinds to before the most recent `#pause`.

Use `#only` to add animations in arbitrary order.

### Fonts available on this system

Prefer: `DejaVu Sans Mono` (monospace), `DejaVu Sans` (sans-serif).
Variable fonts (`Ubuntu`, `Ubuntu Mono`) may render incorrectly — avoid.

---

## Workflow

1. Edit `slides.typ` — it is the deliverable.
2. Images go in `media/`; reference them as relative paths: `image("media/foo.jpg")`.
3. Compile with `typst compile slides.typ` from the repo root.
4. Tag a release (`vX.Y.Z`) to trigger the GitHub Actions build → PDF attached to the release.

---

## Content conventions

- **Presenter notes** are written for the *speaker* — talking points, punchlines, things to watch for.
- **Memes** are first-class slide content.
- **Slide density**: prefer one strong idea per slide; use `#pause` for progressive reveal.
- **Prices and model data**: source from OpenRouter (`openrouter.ai/models`); include attribution and date.

# Intermediate Agentic AI

Slides for an intermediate, hands-on Agentic AI session — a follow-on to the beginner
tutorial. Presenter: Dr. Gaurav Manek, A\*STAR.

The deck is written in [Typst](https://typst.app/) using the
[Touying](https://touying-typ.github.io/) presentation framework with the metropolis theme.

## Building

```bash
typst compile slides.typ
```

This produces `slides.pdf`. Pushing a `vX.Y.Z` tag (or running the workflow manually)
builds the PDF in CI and attaches it to a GitHub release.

## Layout

`slides.typ` is the single deliverable. It defines a small set of layout macros
(`label-item`, `gblock`, `lblock`, `similar`) and demonstrates the established slide
patterns. See `CLAUDE.md` for the full conventions.

## Workshop resources

The participant starter-prompts and the live-demo prompts live in a companion repository:
[**intermediate-agentic-ai-resources**](https://github.com/gauravmm/intermediate-agentic-ai-resources).

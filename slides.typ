#import "@preview/touying:0.7.4": *
#import themes.metropolis: *

#import "@preview/tiaoma:0.3.0": qrcode
#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Intermediate Agentic AI],
    subtitle: [Building Real Agents],
    author: [Dr. Gaurav Manek, Ocellivision, IMCB],
    date: datetime.today(),
    institution: [TechWorks\@ROCK],
    logo: [🤖💥🧠🧑‍💻],
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

// Labelled row item: bold title + inline description, fills grid cell height.
#let label-item(title, body) = box(
  fill: luma(240),
  width: 100%,
  height: 100%,
  radius: 0.5em,
  outset: (left: 0.5em, right: 0.5em),
  inset: (top: 0.5em, bottom: 0.5em),
  [#text(size: 1.2em, weight: "bold")[#title] \ #body],
)

#let gblock(body, inset: 0.4em, outset: 0.4em, width: 100%) = block(
  fill: luma(235),
  inset: inset,
  outset: outset,
  radius: 0.4em,
  width: width,
)[#body]

#let lblock(body, inset: 0.4em, outset: 0.4em, width: 100%) = block(
  fill: white,
  stroke: 0.5pt + luma(220),
  inset: inset,
  outset: outset,
  radius: 0.4em,
  width: width,
)[#body]

#let similar(items) = lblock(inset: (x: 0.6em, y: 0.4em), outset: 0pt)[
  #text(size: 0.85em, fill: luma(80))[#text(weight: "bold")[Other examples] --- #items]
]

#title-slide()

= Section One

== A Slide With a Title

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  align: top,
  grid(
    columns: 1,
    rows: 1fr,
    gutter: 0.4em,
    label-item[First Idea][A bold label and a one-line description that fills the cell.],
    label-item[Second Idea][Stack these in a single-column grid to make a tidy list.],
    label-item[Third Idea][Use `rows: 1fr` so every row stretches to equal height.],
  ),

  [
    #v(1fr)

    The right column carries the framing or the punchline:
    #lblock(inset: 0.8em, outset: 0pt)[
      #align(center)[
        *One strong idea per slide.*
      ]
    ]

    #v(1fr)
    + Reveal progressively with `#pause`.
    + Keep density low.
    + Let the speaker notes carry the detail.

    #v(1fr)
  ],
)

#speaker-note[
  - This is the canonical two-column layout: list on the left, framing on the right
  - Talking points live here, hidden from the audience
  - Replace this scaffold with real content
]

== Progressive Reveal

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    *Before*
    #gblock[The audience sees this first.]
    #pause
  ],
  [
    *After*
    #gblock[Then this appears on the next subslide.]
  ],
)

#speaker-note[
  - `#pause` and `#meanwhile` are processed in source order, not grid position
  - Use `grid.cell(x:, y:)` to control reveal order in a 2x2 grid
]

#focus-slide[
  A big statement \
  for emphasis.
]

= Let's Get Started

#focus-slide[
  #grid(
    columns: (1fr, auto),
    align: horizon,
    gutter: 2em,
    [
      #text(size: 2.8em)[
        Let's build something.
      ]\

      #text(font: "DejaVu Sans Mono", size: 1.2em)[
        manek.sg/intmd-1
      ]
    ],
    [
      #box(fill: white, inset: 1em)[
        #qrcode("https://manek.sg/intmd-1", width: 8cm)
      ]
    ],
  )
]

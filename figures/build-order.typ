#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let accent = rgb("#c7793e")
#let red-line = rgb("#cc3322")
#let green-line = rgb("#2e8b57")

// A "rough order of concerns" for building an agent system: a short linear
// DECIDE run (asked once) that hands off into an iterate-forever BUILD loop.
// The dotted arrow back to the architecture node makes the point that the
// order is rough - testing often sends you back to an earlier decision.
#diagram(
  spacing: (3.4em, 1.0em),
  node-stroke: 0.8pt,
  node-fill: luma(240),
  node-corner-radius: 4pt,
  label-size: 0.85em,

  // ── zone labels (to the right of each band) ──
  node(
    (-0.4, -0.7),
    align(left)[#text(weight: "bold")[Decide]],
    stroke: none,
    fill: none,
  ),
  node(
    (-0.4, 3.4),
    align(left)[#text(weight: "bold")[Build]],
    stroke: none,
    fill: none,
  ),

  // ── DECIDE column (x = 0), top -> down ──
  node((0, 0), align(center)[Simplest next feature?], width: 8cm, name: <feature>),
  node((0, 1), align(center)[What to get right?], fill: rgb("#f6ece1"), width: 8cm),
  node((0, 2), align(center)[Pick an architecture], width: 8cm),
  edge((0, 0), (0, 1), "-|>"),
  edge((0, 1), (0, 2), "-|>"),

  // ── hand off into the build loop ──
  edge((0, 2), (0, 4), "-|>"),

  // ── dashed grey frame around the build loop ──
  node(
    enclose: ((0, 4), (0, 6)),
    inset: 7pt,
    corner-radius: 8pt,
    stroke: (paint: luma(160), thickness: 1pt, dash: "dashed"),
    fill: none,
  ),

  // ── BUILD column (x = 0), continuing down ──
  node((0, 4), align(center)[Implement], fill: rgb("#eef1f5"), width: 8cm, name: <implement>),
  node((0, 5), align(center)[Play with it], fill: rgb("#eef1f5"), width: 8cm),
  node((0, 6), align(center)[Properly evaluate it], fill: rgb("#eef1f5"), width: 8cm, name: <evaluate>),
  edge((0, 4), (0, 5), "-|>"),
  edge((0, 5), (0, 6), "-|>"),

  // ── decision triangle to the left of evaluate: pass or loop? ──
  node(
    (-0.8, 6),
    text(size: 0.62em)[pass?],
    shape: fletcher.shapes.diamond,
    fill: accent,
    stroke: 0.8pt,
    inset: 2pt,
    name: <decision>,
  ),
  edge(<evaluate>, <decision>, "-|>"),

  // ── iterate (red): decision loops back to implement (inner left channel) ──
  edge(
    <decision>,
    (-0.8, 4),
    <implement>,
    "-|>",
    stroke: red-line,
    label: rotate(-90deg, reflow: true, text(size: 1em, fill: red-line)[iterate]),
    label-side: left,
    label-pos: 0.25,
  ),

  // ── revisit (green): a failed evaluation sends you back to the decide
  //    questions (outer left channel) ──
  edge(
    <decision>,
    (-1.1, 6),
    (-1.1, 0),
    <feature>,
    "..|>",
    stroke: green-line,
    label: rotate(-90deg, reflow: true, text(size: 1em, fill: green-line)[revisit]),
    label-side: right,
    label-pos: 0.5,
  ),
)

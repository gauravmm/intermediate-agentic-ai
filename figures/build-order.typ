#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let accent = rgb("#c7793e")

// A "rough order of concerns" for building an agent system: a short linear
// DECIDE run (asked once) that hands off into an iterate-forever BUILD loop.
// The dotted arrow back to the architecture node makes the point that the
// order is rough - testing often sends you back to an earlier decision.
#diagram(
  spacing: (3.4em, 3.2em),
  node-stroke: 0.8pt,
  node-fill: luma(240),
  node-corner-radius: 4pt,
  label-size: 0.85em,

  // ── zone labels ──
  node(
    (-0.6, 0),
    align(right)[#text(weight: "bold")[Decide] \ #text(size: 0.8em, fill: luma(110))[once]],
    stroke: none,
    fill: none,
  ),
  node(
    (2.7, 1),
    align(left)[#text(weight: "bold")[Build] \ #text(size: 0.8em, fill: luma(110))[loop]],
    stroke: none,
    fill: none,
  ),

  // ── DECIDE row (y = 0), left -> right ──
  node((0, 0), align(center)[Bare \ minimum?]),
  node((1, 0), align(center)[What to \ get right?], fill: rgb("#f6ece1")),
  node((1, -0.6), text(size: 0.72em, fill: accent, weight: "bold")[8 principles], stroke: none, fill: none),
  node((2, 0), align(center)[Pick an \ architecture]),
  edge((0, 0), (1, 0), "-|>"),
  edge((1, 0), (2, 0), "-|>"),

  // ── hand off into the build loop ──
  edge((2, 0), (2, 1), "-|>", label: text(size: 0.8em)[build it]),

  // ── BUILD row (y = 1), right -> left ──
  node((2, 1), [Implement], fill: rgb("#eef1f5")),
  node((1, 1), [Try it], fill: rgb("#eef1f5")),
  node((0, 1), [Test it], fill: rgb("#eef1f5")),
  edge((2, 1), (1, 1), "-|>"),
  edge((1, 1), (0, 1), "-|>"),

  // ── iterate: test loops back to implement (arc below the build row) ──
  edge((0, 1), (2, 1), "-|>", bend: -38deg, label: text(size: 0.8em)[iterate], label-side: center),

  // ── "rough": a failed test can send you back to the decide questions ──
  edge(
    (0, 1),
    (0, 0),
    "..|>",
    stroke: accent,
    label: text(size: 0.78em, fill: accent)[revisit],
    label-side: left,
  ),
)

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let acc = rgb("#c7793e") // orange: rejected path
#let ok = rgb("#6b9c71") // green: accepted path

#diagram(
  spacing: (2.3em, 1.6em),
  node-stroke: 0.8pt,
  node-corner-radius: 4pt,
  node-fill: luma(240),
  label-size: 1em,

  // ── input ──
  node((0.2, 1), align(center)[Task /\ query], fill: luma(225), shape: fletcher.shapes.circle),

  // ── fan-out to parallel search actors ──
  node((1.4, 0), [Search agent A], fill: rgb("#eef3ec")),
  node((1.4, 1), [Search agent B], fill: rgb("#eef3ec")),
  node((1.4, 2), [Search agent C], fill: rgb("#eef3ec")),
  edge((0, 1), (1.4, 0), "-|>"),
  edge((0, 1), (1.4, 1), "-|>"),
  edge((0, 1), (1.4, 2), "-|>"),

  // internet search (self-loop on each actor)
  edge((1.4, 0), (1.4, 0), "-|>", bend: 120deg, label: [web]),
  edge((1.4, 1), (1.4, 1), "-|>", bend: 120deg),
  edge((1.4, 2), (1.4, 2), "-|>", bend: 120deg),

  // ── actor-critic loop per lane ──
  node((2.7, 0), [Critic]),
  node((2.7, 1), [Critic]),
  node((2.7, 2), [Critic]),
  edge((1.4, 0), (2.7, 0), "-|>", bend: 20deg, label: [draft]),
  edge((2.7, 0), (1.4, 0), "-|>", bend: 20deg, label: [revise]),
  edge((1.4, 1), (2.7, 1), "-|>", bend: 20deg),
  edge((2.7, 1), (1.4, 1), "-|>", bend: 20deg),
  edge((1.4, 2), (2.7, 2), "-|>", bend: 20deg),
  edge((2.7, 2), (1.4, 2), "-|>", bend: 20deg),

  // ── fan-in: only the passers (A, C) reach synthesis; B rejected ──
  node((4.3, 1), [Synthesize], fill: luma(232)),
  edge((2.7, 0), (4.3, 1), "-|>", stroke: ok),
  edge((2.7, 2), (4.3, 1), "-|>", stroke: ok),
  node((3.55, 1), text(fill: acc, weight: "bold")[✕], stroke: none, fill: none),
  edge((2.7, 1), (3.55, 1), "..|>", stroke: acc, label: text(fill: acc)[reject]),

  // ── fan-out to endpoints (uniform width) ──
  node((5.5, 0), box(width: 3.4em)[#align(center)[Slides]]),
  node((5.5, 1), box(width: 3.4em)[#align(center)[Email]]),
  node((5.5, 2), box(width: 3.4em)[#align(center)[Log]]),
  edge((4.3, 1), (5.5, 0), "-|>"),
  edge((4.3, 1), (5.5, 1), "-|>"),
  edge((4.3, 1), (5.5, 2), "-|>"),

  // ── gate after each endpoint ──
  node(
    (6.6, 0),
    text(size: 0.65em, fill: white, weight: "bold")[GATE],
    fill: acc,
    stroke: none,
    shape: fletcher.shapes.diamond,
  ),
  node(
    (6.6, 1),
    text(size: 0.65em, fill: white, weight: "bold")[GATE],
    fill: acc,
    stroke: none,
    shape: fletcher.shapes.diamond,
  ),
  node(
    (6.6, 2),
    text(size: 0.65em, fill: white, weight: "bold")[GATE],
    fill: acc,
    stroke: none,
    shape: fletcher.shapes.diamond,
  ),
  edge((5.5, 0), (6.6, 0), "-|>"),
  edge((5.5, 1), (6.6, 1), "-|>"),
  edge((5.5, 2), (6.6, 2), "-|>"),

  // ── fan-in to a single output ──
  node((7.7, 1), [Output], fill: luma(225), shape: fletcher.shapes.circle),
  edge((6.6, 0), (7.7, 1), "-|>"),
  edge((6.6, 1), (7.7, 1), "-|>"),
  edge((6.6, 2), (7.7, 1), "-|>"),
)

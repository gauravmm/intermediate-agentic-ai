#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let acc = rgb("#c7793e") // orange: rejected path
#let ok = rgb("#6b9c71") // green: accepted path

#diagram(
  spacing: (3em, 2em),
  node-stroke: 0.8pt,
  node-corner-radius: 4pt,
  node-fill: luma(240),
  label-size: 1em,

  // ── input ──
  node((0, 1), align(center)[Task /\ query], fill: luma(225)),

  // ── fan-out to parallel search actors ──
  node((1.4, 0), [Search agent A], fill: rgb("#eef3ec")),
  node((1.4, 1), [Search agent B], fill: rgb("#eef3ec")),
  node((1.4, 2), [Search agent C], fill: rgb("#eef3ec")),
  edge((0, 1), (1.4, 0), "-|>"),
  edge((0, 1), (1.4, 1), "-|>", label: [fan-out]),
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
  edge((2.7, 2), (4.3, 1), "-|>", stroke: ok, label: [fan-in]),
  node((3.55, 1), text(fill: acc, weight: "bold")[✕], stroke: none, fill: none),
  edge((2.7, 1), (3.55, 1), "..|>", stroke: acc, label: text(fill: acc)[reject]),

  // ── fan-out to endpoints ──
  node((5.6, 0), [Slides]),
  node((5.6, 1), [Email]),
  node((5.6, 2), align(center)[Log]),
  edge((4.3, 1), (5.6, 0), "-|>"),
  edge((4.3, 1), (5.6, 1), "-|>", label: [fan-out]),
  edge((4.3, 1), (5.6, 2), "-|>"),
)

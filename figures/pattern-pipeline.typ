#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

// Prominent "gate" chip sitting on the flow line between two stages.
#let gate(pos) = node(
  pos,
  text(size: 0.65em, fill: white, weight: "bold")[GATE],
  fill: rgb("#c7793e"),
  stroke: none,
  corner-radius: 3pt,
  inset: 5pt,
)

#diagram(
  spacing: (1.2em, 2em),
  node-stroke: 0.8pt,
  node-corner-radius: 4pt,
  node-fill: luma(240),
  node((0, 0), [Task], fill: luma(225)),
  node((2, 0), [Stage A]),
  node((4, 0), [Stage B]),
  node((6, 0), [Output], fill: luma(225)),
  gate((3, 0)),
  gate((5, 0)),
  edge((0, 0), (2, 0), "-|>"),
  edge((2, 0), (3, 0), "-"),
  edge((3, 0), (4, 0), "-|>"),
  edge((4, 0), (5, 0), "-"),
  edge((5, 0), (6, 0), "-|>"),
)

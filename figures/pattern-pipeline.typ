#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

// Prominent "gate" chip sitting on the flow line between two stages.
#let gate(pos) = node(
  pos,
  text(size: 0.65em, fill: white, weight: "bold")[GATE],
  fill: rgb("#c7793e"),
  stroke: none,
  shape: fletcher.shapes.diamond,
  inset: 5pt,
)

#diagram(
  spacing: (1.2em, 2em),
  node-stroke: 0.8pt,
  node-corner-radius: 4pt,
  node-fill: luma(240),
  node((0, 0), [Task], fill: luma(225), shape: fletcher.shapes.circle),
  node((2, 0), [Stage A]),
  node((4, 0), [Stage B]),
  node((6, 0), [Output], fill: luma(225), shape: fletcher.shapes.circle),
  gate((3, 0)),
  gate((5, 0)),
  // tools available to each stage
  node((2, -1), text(size: 0.8em, style: "italic")[tools], stroke: none, fill: none),
  node((4, -1), text(size: 0.8em, style: "italic")[tools], stroke: none, fill: none),
  edge((2, 0), (2, -1), "--"),
  edge((4, 0), (4, -1), "--"),
  edge((0, 0), (2, 0), "-|>"),
  edge((2, 0), (3, 0), "-"),
  edge((3, 0), (4, 0), "-|>"),
  edge((4, 0), (5, 0), "-"),
  edge((5, 0), (6, 0), "-|>"),
)

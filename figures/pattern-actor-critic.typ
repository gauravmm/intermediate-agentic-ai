#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#diagram(
  spacing: (3em, 2em),
  node-stroke: 0.8pt,
  node-corner-radius: 4pt,
  node-fill: luma(240),
  node((0, 0.5), [Task], fill: luma(225), shape: fletcher.shapes.circle),
  node((1, -0.5), [Critic]),
  node((1, 0.5), [Generator]),
  edge((0, 0.5), (1, -0.5), "-|>"),
  edge((0, 0.5), (1, 0.5), "-|>"),
  edge((1, 0.5), (1, -0.5), "-|>"),
  node((2, 0.5), [Judge]),
  edge((1, -0.5), (2, 0.5), "-|>"),
  edge((1, 0.5), (2, 0.5), "-|>"),
  node((3, 0.5), [Output], fill: luma(225), shape: fletcher.shapes.circle),
  edge((2, 0.5), (3, 0.5), "-|>"),
)

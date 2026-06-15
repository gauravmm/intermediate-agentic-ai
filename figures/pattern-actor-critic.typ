#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#diagram(
  spacing: (3em, 2em),
  node-stroke: 0.8pt,
  node-corner-radius: 4pt,
  node-fill: luma(240),
  node((0, 0.5), [Task], fill: luma(225), shape: fletcher.shapes.circle),
  node((1.2, 0), [Critic]),
  node((1, 1), [Generator]),
  edge((0, 0.5), (1.2, 0), "-|>"),
  edge((0, 0.5), (1, 1), "-|>"),
  edge((1, 1), (1.2, 0), "-|>"),
  node((2, 0.5), [Judge]),
  edge((1.2, 0), (2, 0.5), "-|>"),
  edge((1, 1), (2, 0.5), "-|>"),
  node((3, 0.5), [Output], fill: luma(225), shape: fletcher.shapes.circle),
  edge((2, 0.5), (3, 0.5), "-|>"),
)

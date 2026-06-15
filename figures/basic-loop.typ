#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#diagram(
  spacing: 3.5em,
  node-stroke: 0.8pt,
  node-fill: luma(240),
  node-corner-radius: 4pt,
  node((0, 0), [Task], fill: luma(225), shape: fletcher.shapes.circle),
  node((1, 0), [Agent]),
  node((2, 0), [Output], fill: luma(225), shape: fletcher.shapes.circle),
  edge((0, 0), (1, 0), "-|>"),
  edge((1, 0), (2, 0), "-|>"),
  edge((1, 0), (1, 0), "-|>", bend: 130deg),
)

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#diagram(
  spacing: (2.8em, 1.5em),
  node-stroke: 0.8pt,
  node-corner-radius: 4pt,
  node-fill: luma(240),
  node((0, 1), [Task], fill: luma(225)),
  node((1, 1), [Router]),
  edge((0, 1), (1, 1), "-|>"),
  node((2, 0), [Cheap model]),
  node((2, 1), [Specialist A]),
  node((2, 2), [Specailist B]),
  edge((1, 1), (2, 0), "-|>"),
  edge((1, 1), (2, 1), "-|>", label: text(size: 0.7em)[pick one]),
  edge((1, 1), (2, 2), "-|>"),
)

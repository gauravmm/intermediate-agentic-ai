#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#diagram(
  spacing: (2.6em, 1.5em),
  node-stroke: 0.8pt,
  node-corner-radius: 4pt,
  node-fill: luma(240),
  node((0, 1), [Task], fill: luma(225)),
  node((1, 0), [Sub-agent], fill: rgb("#eef3ec")),
  node((1, 1), [Sub-agent], fill: rgb("#eef3ec")),
  node((1, 2), [Sub-agent], fill: rgb("#eef3ec")),
  edge((0, 1), (1, 0), "-|>", label: text(size: 0.7em)[fan-out]),
  edge((0, 1), (1, 1), "-|>"),
  edge((0, 1), (1, 2), "-|>"),
  node((2, 1), [Synthesize], fill: luma(232)),
  edge((1, 0), (2, 1), "-|>"),
  edge((1, 1), (2, 1), "-|>", label: text(size: 0.7em)[fan-in]),
  edge((1, 2), (2, 1), "-|>"),
  node((3, 1), [Output], fill: luma(225)),
  edge((2, 1), (3, 1), "-|>"),
)

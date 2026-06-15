#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let acc = rgb("#c7793e") // orange: rejected path
#let ok = rgb("#6b9c71") // green: accepted path

// Reduced-vertical-space variant of task-agent.typ: a single agent per stage
// (one lane instead of three) so the whole flow sits on one row. The terminal
// circles (Task / query, Output) carry their labels outside the node so the
// circles stay small.
#diagram(
  // Integer columns -> fletcher's elastic grid gives a uniform gap (spacing.x)
  // between every stage, regardless of node width.
  spacing: (1.3em, 1.6em),
  node-stroke: 0.8pt,
  node-corner-radius: 4pt,
  node-fill: luma(240),
  label-size: 1em,

  // ── input terminal: circle with its label outside (left) ──
  node((0, 1), [], fill: luma(225), shape: fletcher.shapes.circle, radius: 0.9em),
  node((-0.7, 1), align(right)[Task /\ query], stroke: none, fill: none),

  // ── single search agent ──
  node((1, 1), [Search agent A], fill: rgb("#eef3ec")),
  edge((0, 1), (1, 1), "-|>"),
  // internet search (self-loop)
  edge((1, 1), (1, 1), "-|>", bend: 120deg, label: [web]),

  // ── actor-critic loop ──
  node((2, 1), [Critic]),
  edge((1, 1), (2, 1), "-|>", bend: 20deg, label: [draft]),
  edge((2, 1), (1, 1), "-|>", bend: 20deg, label: [revise]),
  // reject: critic kills the draft (curves down-and-right to a dead end)
  node((2.6, 1.5), text(fill: acc, weight: "bold")[✕], stroke: none, fill: none),
  edge((2, 1), (2.6, 1.5), "..|>", stroke: acc, bend: -35deg),

  // ── synthesis ──
  node((3, 1), [Synthesize], fill: luma(232)),
  edge((2, 1), (3, 1), "-|>", stroke: ok),

  // ── single output channel: Email ──
  node((4, 1), [Email]),
  edge((3, 1), (4, 1), "-|>"),

  // ── gate after the endpoint ──
  node(
    (5, 1),
    text(size: 0.65em, fill: white, weight: "bold")[GATE],
    fill: acc,
    stroke: none,
    shape: fletcher.shapes.diamond,
  ),
  edge((4, 1), (5, 1), "-|>"),

  // ── output terminal: circle with its label outside (right) ──
  node((6, 1), [], fill: luma(225), shape: fletcher.shapes.circle, radius: 0.9em),
  node((6.7, 1), align(left)[Output], stroke: none, fill: none),
  edge((5, 1), (6, 1), "-|>"),
)

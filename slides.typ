#import "@preview/touying:0.7.4": *
#import themes.metropolis: *

#import "@preview/tiaoma:0.3.0": qrcode
#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#import "theme.typ": big-section-slide

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(new-section-slide-fn: big-section-slide),
  config-info(
    title: [Intermediate Agentic AI],
    subtitle: [Building Real Agents],
    author: [Dr. Gaurav Manek, Ocellivision, IMCB],
    date: datetime.today(),
    institution: [Ocellivision + TechWorks\@ROCK],
    logo: [🤖💥🧠🧑‍💻],
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

// Labelled row item: bold title + inline description, fills grid cell height.
#let label-item(title, body) = box(
  fill: luma(240),
  width: 100%,
  height: 100%,
  radius: 0.5em,
  outset: (left: 0.5em, right: 0.5em),
  inset: (top: 0.5em, bottom: 0.5em),
  [#text(size: 1.2em, weight: "bold")[#title] \ #body],
)

#let gblock(body, inset: 0.4em, outset: 0.4em, width: 100%) = block(
  fill: luma(235),
  inset: inset,
  outset: outset,
  radius: 0.4em,
  width: width,
)[#body]

#let lblock(body, inset: 0.4em, outset: 0.4em, width: 100%) = block(
  fill: white,
  stroke: 0.5pt + luma(220),
  inset: inset,
  outset: outset,
  radius: 0.4em,
  width: width,
)[#body]

#let similar(items) = lblock(inset: (x: 0.6em, y: 0.4em), outset: 0pt)[
  #text(size: 0.85em, fill: luma(80))[#text(weight: "bold")[Other examples] --- #items]
]

// Numbered principle: big grey index number + bold title, one-line body, optional example.
#let principle(num, title, body, example: none) = grid(
  columns: (1.5em, 1fr),
  column-gutter: 0.7em,
  row-gutter: 0.1em,
  align: (right + top, left + top),
  text(weight: "bold", size: 3em, fill: luma(140))[#num.],
  [
    *#title* \
    #body
    #if example != none [
      \ #text(size: 0.85em, fill: luma(100))[_e.g._ #example]
    ]
  ],
)

// Visible placeholder for a proposed graphic. Draft only; replace with the real figure.
#let gfx(desc) = align(center)[
  #block(
    fill: luma(245),
    stroke: (paint: luma(170), dash: "dashed"),
    radius: 0.4em,
    inset: 1em,
    width: 92%,
  )[#text(fill: luma(90))[🖼 #text(weight: "bold")[Graphic:] #desc]]
]

// Accent colour shared by the pattern diagrams (gates) and the helps column.
#let accent = rgb("#c7793e")

// The eight principles, in order; index in this list == principle number.
#let principle-names = (
  [Context rot],
  [Credulity],
  [Abstraction],
  [Specialization],
  [Observability],
  [Least privilege],
  [Testability],
  [Cost or latency],
)

// Number badge: orange when the principle applies, muted grey otherwise.
#let pnum(n, on) = box(
  fill: if on { accent } else { luma(210) },
  inset: (x: 0.42em, y: 0.12em),
  radius: 0.3em,
  baseline: 0.2em,
  text(fill: white, weight: "bold", size: 0.8em)[#n],
)

// Right-hand sidebar: always lists all 8 principles; lights up the ones a
// pattern serves. `applies` is an array of principle numbers, e.g. (1, 4, 7).
#let helps(applies) = [
  #v(1fr)
  #text(size: 0.8em, fill: luma(120), weight: "bold", tracking: 0.08em)[HELPS WITH]
  #v(0.1em)
  #for (i, name) in principle-names.enumerate() {
    let n = i + 1
    let on = applies.contains(n)
    [
      #pnum(n, on) #h(0.35em) #text(
        size: 1em,
        fill: if on { accent } else { luma(165) },
        weight: if on { "bold" } else { "regular" },
      )[#name]\
      #v(0em)
    ]
  }
  #v(1fr)
]

// Footer: the canonical name each source uses for this pattern.
// 3-column grid so the dot separators line up vertically.
#let terms(anthropic, openai) = lblock(inset: (x: 0.7em, y: 0.45em), outset: 0pt)[
  #text(size: 0.85em, fill: luma(60))[
    #grid(
      columns: (auto, auto, 1fr),
      column-gutter: 0.5em,
      row-gutter: 0.35em,
      align: (right + horizon, center + horizon, left + horizon),
      text(weight: "bold")[Anthropic], sym.dot.c, anthropic,
      text(weight: "bold")[OpenAI], sym.dot.c, openai,
    )
  ]
]

// A full pattern slide body: caption + diagram + a real-world example on the
// left, helps column on the right, source terms along the bottom. Drop in under
// a `==` slide heading.
#let pattern-slide(diagram, caption, example, applies, anthropic, openai) = {
  grid(
    columns: (1fr, 6.5cm),
    column-gutter: 1.5em,
    align: horizon,
    [
      #v(1em)
      #caption
      #v(1fr)
      #align(center)[#diagram]
      #v(0.7em)
      #text(size: 0.85em, fill: luma(100))[
        #grid(
          columns: (auto, 1fr),
          column-gutter: 0.4em,
          align: (right + top, left + top),
          [*Real-world:*], example,
        )
      ]
      #v(1fr)
      #box(width: 100%, terms(anthropic, openai))
    ],
    helps(applies),
  )
  v(0.5em)
}

#title-slide()

// ============================================================================
// DRAFT. Content dumped from spec/CONTENT.md, organised by topic. Not arranged
// for flow or density yet. Graphic proposals are marked with #gfx[...].
// ============================================================================
= How to think about agents

== Where we're starting from
// Zero bottom margin so the diagrams can run to the slide edge; drop the footer
// so it doesn't crowd the content.
#slide(config: config-page(margin: (top: 3em, bottom: 0em), footer: none))[
  #v(-1em)
  You've built a toy agent. You know the basic loop:
  #v(-1em)
  #align(center)[
    #include "figures/basic-loop.typ"
  ]
  This *workflow* is what we're building today:
  #v(-1em)
  #align(center)[
    #include "figures/task-agent.typ"
  ]

  #lblock()[
    Each *agent* has its own input, prompt, tools, and output. How can we arrange them best?
  ]

  #speaker-note[
    - Anchor on what the beginner session already covered: the act/observe loop
    - The gap we're closing today: toy that works once -> system you can trust
  ]
]


== What an agent really is

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  align: horizon,
  [
    #text(size: 1.3em)[
      An agent is a powerful but imprecise *LLM*, wrapped in the engineering
      that makes it *reliable*, *performant*, *understandable*, and *safe*.
    ]
  ],
  [
    #align(center)[
      #image("media/engine-aircraft.png", height: 75%)
    ]
  ],
)

#speaker-note[
  - You own reliability; the model just makes fuzzy decisions
  - Jet engine vs aircraft: LLM is the engine, the engineering is airframe + pilot
  - The four properties are what the airframe buys; the engine alone gives none
]


== Why can't we just use ONE agent?

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  row-gutter: 1em,
  align: (top + left),
  principle([1], [Context rot], [keep each window small and on-task.]),
  principle([2], [Credulity], [the agent trusts too much.]),

  principle([3], [Abstraction], [allow higher-level processes to ignore irrelevant details about low-level tasks.]),
  principle([4], [Specialization], [a focused prompt and few tools beats a kitchen sink.]),

  principle([5], [Observability], [see every step, not just the answer.]),
  principle([6], [Least privilege], [scope tools per stage to avoid security breaches.]),

  principle([7], [Testability], [understand the performance of each step and build confidence.]),
  principle([8], [Cost & latency], [route cheap models for the easy steps, or get the job done quicker.]),
)

One big agent fails in ways you can't see, fix, or contain.

#speaker-note[
  Motivating example: a "research assistant" you ask to research a topic and email a summary.
  As ONE agent it must search the web, read ~20 pages, draft, and send the mail - all in one context.
  Walk the same eight numbers down the failure modes:
  - Context rot: 20 raw pages crowd out the original task.
  - Credulity: one poisoned page and it follows the instructions hidden in it.
  - Abstraction / Specialization: search, write, and send are jammed into one fuzzy prompt.
  - Observability: it emails the wrong person - which step went wrong? You can't tell.
  - Least privilege: it holds web + file + send-email tools the entire time.
  - Testability: you can't test "find sources" apart from "write the summary".
  - Cost & latency: a frontier model burns tokens on trivial fetches.
  Each failure maps to one principle - and each is fixed by splitting the work, which is the next section.
]


= Common workflow patterns

== Pattern 1: Pipeline, not one mega-agent

#pattern-slide(
  include "figures/pattern-pipeline.typ",
  [Each stage has its own prompt, tools, and test. Some kind of *deterministic*  gate sits between them.],
  [Invoice processing: read the PDF, extract line items, validate some policy, then post to accounting.],
  (1, 4, 5, 6, 7),
  [Prompt chaining],
  [Deterministic / sequential workflow],
)

#speaker-note[
  - The default starting shape: a fixed code path with an LLM call at each step
  - Gates are plain code (validation, retries) - not another agent
]

== Pattern 2: Fan-out subagents

#pattern-slide(
  include "figures/pattern-fanout.typ",
  [Children do the wide reading; the parent stays small and just synthesizes.],
  [Company brief before a meeting: one sub-agent per source (news, filings, profiles), merged into one page.],
  (1, 4, 8),
  [Orchestrator-workers / parallelization],
  [Manager pattern ("agents as tools")],
)

#speaker-note[
  - Each child's context is thrown away after it returns a short result - that's the win
  - Parallel, so latency is the slowest child, not the sum
]

== Pattern 3: Routing / triage

#pattern-slide(
  include "figures/pattern-routing.typ",
  [Classify first, then send down one path with the right model and tools.],
  [Customer support: "reset my password" goes to the FAQ bot; "dispute this charge" to a billing specialist.],
  (8, 4, 6),
  [Routing],
  [Triage agent + handoffs],
)

#speaker-note[
  - The router is cheap and does one thing: classify and dispatch
  - Easy questions go to a small model; only the hard path pays for the big one
]

== Pattern 4: Actor-critic / generate-then-verify

#pattern-slide(
  include "figures/pattern-actor-critic.typ",
  [Generator and critic each take the task; a judge (or the critic) weighs both into the output.

    _This works even when all the models are identical... why?_
  ],
  [Scientific analysis: one model interprets the results, another challenges the stats and confounds, a judge keeps what holds up.],
  (2, 7),
  [Evaluator-optimizer],
  [Guardrails + LLM-as-judge],
)

#speaker-note[
  - The critic is a fresh context with one job: find what's wrong
  - The judge sees both the draft and the critique, then decides - no spin loop
]

== Which patterns can you spot?

#align(center)[
  #include "figures/task-agent.typ"
]

#v(0.5em)
#pause

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  row-gutter: 1em,
  lblock(inset: (x: 0.6em, y: 0.5em))[#align(center)[Pipeline]],
  lblock(inset: (x: 0.6em, y: 0.5em))[#align(center)[Fan-out subagents]],

  lblock(inset: (x: 0.6em, y: 0.5em))[#align(center)[Actor-critic]],
  lblock(inset: (x: 0.6em, y: 0.5em))[#align(center)[Routing / triage]],
)

== Many, many patterns

// Pull content out to a 1em side margin (theme default is 2em).
#pad(x: -.8em)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    align: top,
    [
      - *Evaluator-optimizer / actor-critic* - one generates, one critiques.
      - *Routing* - classify, send to a specialized path or model.
      - *Parallelization / fan-out* - sectioning (independent subtasks) + voting (same task N times for confidence).
      - *Orchestrator-workers / manager / supervisor* - decompose, delegate, synthesize.
      - *Handoffs / decentralized control* - agents pass control to each other.
      - *Prompt chaining / sequential workflow* - steps with programmatic gates between them.
    ],
    [
      - *ReAct (reason + act)* - interleave a thought with each tool call.
      - *Plan-and-execute* - draft the whole plan first, then run the steps.
      - *Reflexion / self-correction* - retry using feedback from past attempts.
      - *RAG / retrieval-augmented* - pull relevant knowledge into context on demand.
      - *Tree-of-thoughts / search* - branch into candidates, score, then prune.
      - *Human-in-the-loop / escalation* - pause for a person at risky or low-confidence steps.

      #lblock(inset: 0.2em)[
        The list is near-infinite. \
        *Experiment* and find what works for you.
      ]
    ],
  )
]


#speaker-note[
  - These layer on top of the structural patterns; most agents combine several
  - ReAct + RAG is the workhorse; escalation is the safety net
]

= Rules for individual agents


== Many agents make a pipeline

#v(1fr)

How do we design *each agent*, and the *handoff* between agents?

#align(center)[
  #include "figures/task-agent.typ"
]

#v(1fr)
- *Agent Design* What agents do we have? What do each of them specialize in?
- *Handoff Design* What information must they pass to one another?
#v(1fr)

== One agent, one job

#align(center)[
  #include "figures/task-agent-linear.typ"
]
#v(1fr)


#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  row-gutter: 1em,
  align: (top + left),
  principle([1], [One agent, one job], [narrow scope = predictable, testable, and enforceable behaviour.]),
  principle([2], [Keep context small and relevant], [long context degrades, costs more, hides the signal.]),

  principle([3], [Explicit stop conditions], [don't let it spin forever, burning millions of tokens.]),
  principle([4], [State the plan, then act], [you can check the plans and execution separately.]),

  principle([5], [Give it an escape hatch], ["if you can't do it, tell me" allows it to degrade gracefully.]),
  principle(
    [6],
    [Least privilege],
    [can't leak data you don't have, and can't break things that you can't touch.],
  ),
)

#speaker-note[
  - These are the per-agent discipline rules; map to OpenAI "instructions" + Anthropic principles
  - Escape hatch is underrated: forced guesses are where agents quietly go wrong
]

== Handoffs

#align(center)[
  #include "figures/task-agent-linear.typ"
]
#v(1fr)


#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  row-gutter: 1em,
  align: (top + left),
  principle([1], [Pass just enough information], [a small, structured result; not your whole conversation.]),
  principle([2], [One owner at a time], [control transfers explicitly; never two agents on one task.]),

  principle([3], [Make the seam observable], [log every handoff so you can find where it broke.]),
  principle(
    [4],
    [Test/enforce the interface],
    [use automated tests to enforce correctess and structure.],
  ),
)
#v(1fr)
#pause
#lblock()[
  *For this class:* Write each handoff in a named file in a folder.\
  e.g. `query_1/search_A_draft_2.md` or `query_1/email.md`
]
#v(1fr)

#speaker-note[
  - Treat the handoff as an API between agents - the seam, not the insides
  - Contract vs transcript: pass the result, not the context that produced it
  - One owner: ambiguous control is where two agents fight or both go idle
  - Versioned interface sets up the prompt + version-management slide later
]

= Tool design

== Tools are the agent's API; design them like one

- *The schema is the prompt.* Naming + descriptions matter as much as the code.
- *Token efficiency.* Terse, structured returns; paginate / truncate big outputs; don't dump raw blobs into context.
- *Determinism.* Same input -> same output where possible; push variability out of the tool.
- *Good errors.* Actionable messages the model can recover from (backpressure).
- *Validation at the boundary.* Reject bad args; don't let the model corrupt state.
- *Idempotency / safety* for anything with side effects.

#gfx[Before/after of a tool return: a giant raw JSON blob vs. a terse structured summary. "What the model sees" framing.]

#speaker-note[
  - Anthropic's ACI (agent-computer interface) idea: tools are UX for the model
  - "poka-yoke" / make mistakes hard to make is the throughline
]

= Testing

== You can't fix what you can't see

- *Evals* - without them you're flying blind.
- *Fixtures* - recorded conversations / tool transcripts; replay them.
- *Test tools in isolation* - they're just functions; test them deterministically.
- *LLM-as-judge* for fuzzy outputs; know its failure modes.
- *Regression suite* over real past failures.
- *Adversarial / red-team* - try to break safety and liveness guarantees.

#gfx[A test pyramid adapted for agents: deterministic tool tests at the base, fixture replays in the middle, LLM-as-judge + red-team at the top.]

#speaker-note[
  - Loose end to fold in: prompt/version management across a fleet of agents
  - LLM-as-judge is convenient but has its own failure modes; flag this
]

== Loose end: prompt + version management

Across a fleet of agents you need to version prompts like code, and test on change.

#gfx[A simple diagram: prompt registry -> many agents, with version tags and a "diff/rollback" affordance.]

#speaker-note[
  - TODO in the plan: this belongs under testing / production hygiene
]

= Agent safety & governance

== Agents from this workshop...

// Big "not" set beside a couple of lines of text; the whole list sits in the
// left half of the slide.
#let nope(body) = grid(
  columns: (auto, 1fr),
  column-gutter: 0.5em,
  align: (right + horizon, left + horizon),
  text(weight: "bold", size: 2.4em, fill: accent)[not], body,
)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  [
    #stack(
      spacing: 1.5em,
      nope[for private data,],
      nope[allowed to make irreversible or expensive decisions,],
      nope[given access to production or secure systems,],
      nope[allowed to talk to anyone who isn't warned about them.],
      nope[trusted without human oversight],
    )
  ],
  [
    #pause
    #align(horizon)[
      #text(size: 2.2em, weight: "bold")[
        ...because agents have *real* risks.
      ]
    ]
  ],
)

== Agents act in the real world

#grid(
  columns: (.7fr, auto, 1fr),
  column-gutter: 1em,
  align: horizon,
  // Left: the risks an agent *inherits* - generative over traditional software.
  grid(
    columns: (1fr,),
    row-gutter: 0.5em,
    align: horizon,
    gblock[
      *Generative AI risks*
      - Hallucinations
      - Prompt injection
      - Data leakage
      - Biased output
    ],
    align(center)[#text(size: 1.8em, weight: "bold", fill: accent)[+]],
    gblock[
      *Traditional software risks*
      - SQL injection
      - Broken auth / access control
      - Unsafe deserialization
      - Secrets in logs
    ],
  ),
  // Middle: the agent's exposure is *greater* than just its inherited risks.
  text(size: 1.8em, weight: "bold", fill: accent)[<],
  // Right: the risks that are *new* to acting agents.
  gblock[
    *Agentic AI risks*
    - *Erroneous/Unauthorised/Biased* actions without recourse.
    - *Information leakage*, possibly with compromised tools / MCP servers
    - *Speed & volume* - decisions happen faster than oversight can catch.
    - *Cascading effects* - one early mistake propagates and amplifies.
    - *Agent sprawl* - provenance and compatibility problems.
    - *Collaborative failures* - agents with incorrect or opposing goals.
    - *Aimless token burn* - \$\$\$
  ],
)

#speaker-note[
  - Framing for the whole section, from IMDA's MGF for Agentic AI (v1.5, May 2026)
  - The new capability (taking actions) is exactly the new risk
]

= How to implement

#focus-slide[
  Start with the simplest thing. \
  One agent + good tools beats a multi-agent maze.
]

= Let's Get Started

#focus-slide[
  #grid(
    columns: (1fr, auto),
    align: horizon,
    gutter: 2em,
    [
      #text(size: 2.8em)[
        Let's build something.
      ]\

      #text(font: "DejaVu Sans Mono", size: 1.2em)[
        manek.sg/intmd-1
      ]
    ],
    [
      #box(fill: white, inset: 1em)[
        #qrcode("https://manek.sg/intmd-1", width: 8cm)
      ]
    ],
  )
]

= Sources & further reading

== Resources

- *Anthropic* - "Building Effective Agents" - workflows vs. agents; 5 workflow patterns.
- *OpenAI* - "A Practical Guide to Building Agents" (~30pp PDF) - single vs. multi-agent; manager vs. handoff.
- *Victor Dibia* - "Designing Multi-Agent Systems" (2025, 15 ch.) - systems as computational graphs; production depth.
- *IMDA Singapore* - "Model AI Governance Framework for Agentic AI" (v1.5, May 2026) - organisation-facing agent governance.

#speaker-note[
  - IMDA framework is a living document; they invite feedback and case studies
  - Good handout: concrete, organisation-facing, vendor-neutral
]

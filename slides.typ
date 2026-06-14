#import "@preview/touying:0.7.4": *
#import themes.metropolis: *

#import "@preview/tiaoma:0.3.0": qrcode
#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
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
    columns: (1fr, auto),
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

You've built a toy agent. You know the basic loop:

#align(center)[
  #include "figures/basic-loop.typ"
]

This is what we're building today.

#align(center)[
  #include "figures/task-agent.typ"
]

#speaker-note[
  - Anchor on what the beginner session already covered: the act/observe loop
  - The gap we're closing today: toy that works once -> system you can trust
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

One big agent fails in ways you can't see, fix, or contain.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  row-gutter: 1em,
  align: (top + left),
  principle([1], [Context rot], [keep each window small and on-task.]),
  principle([2], [Credulity], [the agent trusts too much.]),

  principle([3], [Abstraction], [offer a stable interface for each stage.]),
  principle([4], [Specialization], [a focused prompt and few tools beats a kitchen sink.]),

  principle([5], [Observability], [see every step, not just the answer.]),
  principle([6], [Least privilege], [scope tools per stage to avoid security breaches.]),

  principle([7], [Testability], [understand the performance of each step and build confidence.]),
  principle([8], [Cost & latency], [route cheap models for the easy steps.]),
)

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


= Common patterns

== Split work; don't build one mega-agent

Four patterns do almost all the work. The next slides show a minimum version of each.

- *Pipeline vs. single mega-agent* - splitting helps context, focus, and testability.
- *Fan-out subagents* - spawn N agents to search the web / a codebase in parallel, then synthesize. Parent stays small; children do the wide reading.
- *Actor-critic / generate-then-verify* - adversarial check before committing.
- *Routing / triage* - cheap/expensive split, or for specialized tools and prompts.


#speaker-note[
  - Everyone agrees across the sources: start with the simplest thing that works
  - Most "agent" problems are actually a prompt or a script in disguise
]
#speaker-note[
  - This is the menu; each pattern can get its own slide if time allows
  - Tie each back to "why split": context, focus, testability
]

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
  [Generator and critic each take the task; a judge (or the critic) weighs both into the output.],
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
  lblock(inset: (x: 0.6em, y: 0.5em))[#align(center)[*Fan-out subagents*]],

  lblock(inset: (x: 0.6em, y: 0.5em))[#align(center)[*Actor-critic*]],
  lblock(inset: (x: 0.6em, y: 0.5em))[#align(center)[*Routing / triage*]],
)

== Many, many patterns

// Pull content out to a 1em side margin (theme default is 2em).
#pad(x: -.8em)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    align: top,
    [
      - *evaluator-optimizer / actor-critic* - one generates, one critiques.
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

#focus-slide[
  Start with the simplest thing. \
  One agent + good tools beats a multi-agent maze.
]

= Rules for individual agents

== One agent, one job

#grid(
  columns: (1fr, 1fr),
  gutter: 0.4em,
  align: top,
  grid(
    columns: 1,
    rows: 1fr,
    gutter: 0.4em,
    label-item[One agent, one job][Narrow scope = predictable behaviour.],
    label-item[Keep context small and relevant][Long context degrades, costs more, hides the signal.],
    label-item[Explicit stop conditions][Don't let it spin.],
  ),
  grid(
    columns: 1,
    rows: 1fr,
    gutter: 0.4em,
    label-item[State the plan, then act][Steerable and auditable.],
    label-item[Give it an escape hatch]["If you can't, say so" beats forcing a guess.],
    label-item[Least privilege][Only the tools it needs for this job.],
  ),
)

#speaker-note[
  - These are the per-agent discipline rules; map to OpenAI "instructions" + Anthropic principles
  - Escape hatch is underrated: forced guesses are where agents quietly go wrong
]

== Handoffs

This is a


#align(center)[
  #include "figures/task-agent.typ"
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

= Conditions for a good pipeline

== You can't fix what you can't see

- *Observability.* Log every step: prompts, tool calls, outputs.
- *Replicability.* Deterministic, re-runnable; capture inputs so a run can be replayed.
- *Checkpointing / resumability.* Don't redo expensive work on failure.
- *Isolation of side effects.* Clear blast radius per stage.
- *Backpressure + rate/cost limits* between stages.

#gfx[A pipeline with a logging/trace rail underneath every stage; a checkpoint marker between stages; a "blast radius" boundary around one stage.]

#speaker-note[
  - Production framing: this is what separates a demo from a system
  - Maps to OpenAI guardrails + Dibia's production chapters
]

= Testing

== Evals are the unit tests of agents

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

== Agents act in the real world

That is the whole risk. A chatbot says the wrong thing; an agent *does* the wrong thing.

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  gblock[
    *Generative AI* \
    Produces text. Worst case: a bad answer.
  ],
  gblock[
    *Agentic AI* \
    Takes actions, touches data, calls other systems. Worst case: a bad action you can't undo.
  ],
)

#v(0.5em)

Agents inherit *traditional software* risks (e.g. SQL injection) #h(0.3em) + #h(0.3em) *LLM* risks (hallucination, bias, data leakage, prompt injection).

#gfx[Split image: a speech bubble (LLM) vs. a robot arm pressing a big red button (agent). "Words vs. actions".]

#speaker-note[
  - Framing for the whole section, from IMDA's MGF for Agentic AI (v1.5, May 2026)
  - The new capability (taking actions) is exactly the new risk
]

== New components, new attack surfaces

Each new agent component is a fresh source of risk:

- *Planning & reasoning* - hallucination or semantic misalignment: a plan that can't achieve the task, contradicts intent, or drifts from an earlier plan.
- *Tools* - call non-existent tools, the wrong tool, the right tool with wrong inputs; prompt/code injection can make the agent exfiltrate or corrupt data.
- *Protocols* - emerging agent-comms protocols can be poorly deployed or compromised, e.g. an untrusted MCP server that exfiltrates user data.

#gfx[The augmented-LLM diagram from earlier, re-used with each component (planner, tools, protocol/MCP) flagged with a small warning icon.]

#speaker-note[
  - Callback to the "augmented LLM" diagram: same parts, now viewed as attack surface
  - MCP example lands well: untrusted server = supply-chain risk for agents
]

== Types of harmful outcome

#grid(
  columns: (1fr, 1fr),
  gutter: 0.4em,
  align: top,
  grid(
    columns: 1,
    rows: 1fr,
    gutter: 0.4em,
    label-item[Erroneous actions][Wrong date booked, flawed code shipped.],
    label-item[Unauthorised actions][Acting outside permitted scope; skipping required approval.],
    label-item[Biased or unfair actions][Biased hiring, procurement, or grant decisions.],
  ),
  grid(
    columns: 1,
    rows: 1fr,
    gutter: 0.4em,
    label-item[Data breaches][Leaking or wrongly modifying sensitive data.],
    label-item[Disruption to connected systems][Deleting a prod codebase; flooding an external API.],
  ),
)

#speaker-note[
  - Agents don't just leak data like an LLM; they can also modify it
  - "Disruption to connected systems" is the one people forget
]

== Systemic & multi-agent risks

- *Speed & volume* - decisions happen faster than oversight can catch; pushing humans to approve everything causes automation bias and alert fatigue.
- *Cascading effects* - one early mistake (e.g. a hallucinated inventory figure) propagates and amplifies downstream.
- *Agent sprawl* - uncontrolled proliferation; provenance and compatibility problems.
- *Collaborative failures* - miscoordination (agents pursue different readings of intent) and conflict (agents optimising opposing goals, e.g. refunds vs. revenue protection).

#gfx[A small multi-agent graph where one red error node cascades through edges to several downstream nodes.]

#speaker-note[
  - Multi-agent makes everything worse: shared context/memory widens the leak surface
  - The refunds-vs-revenue example is a memorable "agents in conflict" case
]

== IMDA's framework: four areas

#grid(
  columns: (1fr, 1fr),
  gutter: 0.4em,
  align: top,
  grid(
    columns: 1,
    rows: 1fr,
    gutter: 0.4em,
    label-item[
      1. Assess & bound risks upfront
    ][Judge by scope of actions, reversibility, and autonomy. Limit tool/system access by design.],
    label-item[
      2. Make humans meaningfully accountable
    ][Assign responsibility across vendors and teams; human checkpoints for high-stakes / irreversible actions.],
  ),
  grid(
    columns: 1,
    rows: 1fr,
    gutter: 0.4em,
    label-item[
      3. Technical controls & processes
    ][Controls for planning/tools/protocols; test execution accuracy, policy adherence, tool use; monitor after deploy.],
    label-item[
      4. Enable end-user responsibility
    ][Tell users the agent's actions, data access, and their own duties; train for effective oversight.],
  ),
)

#speaker-note[
  - This is the spine of the IMDA Model AI Governance Framework for Agentic AI
  - Note it targets organisations deploying agents, in-house or third-party
]

== Practical levers you can pull today

- *Bound by design* - least privilege on tools; prefer reversible actions; match autonomy to stakes.
- *Identity & access management for agents* - so actions are traceable and controllable.
- *Human checkpoints* - require approval for irreversible / high-stakes steps; audit that the oversight stays effective (guard against automation bias).
- *Test new dimensions* - execution accuracy, policy adherence, tool-use correctness.
- *Roll out gradually* - continuous monitoring; not all risks can be anticipated upfront.

#gfx[A "dial" visual: autonomy/scope on one axis, required human oversight on the other; high-stakes actions sit in the "needs a checkpoint" zone.]

#speaker-note[
  - These map onto the four areas; pick the ones relevant to the audience's stage
  - Reversibility is the cheapest lever: a reversible action needs far less oversight
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

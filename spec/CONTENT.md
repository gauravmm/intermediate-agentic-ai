# CONTENT — Intermediate Agentic AI

Rough notes on what to cover. Not a finished plan — a dumping ground for the deck's
content. Reorder / cut / merge freely.

Audience: people who've built a toy agent and want to build real ones. Assume they know
the basic loop (act → observe → act) from the beginner session.

---

## 1. How to think about agents

- Mental model: an agent is a *loop over an LLM with tools*, not a magic box.
- The model is the unreliable part; everything around it is your job to make reliable.
- Agents as employees: you give context, tools, and a goal — not step-by-step instructions.
- When *not* to use an agent: deterministic task → write code; one-shot task → just prompt.
- Cost/latency/reliability triangle — every design choice trades these off.

## 2. Common patterns

- Fan-out subagents: spawn N agents to search the internet / a codebase for ideas in
  parallel, then synthesize. Parent stays small; children do the wide reading.
- Orchestrator + workers; map-reduce over a work list.
- Actor–critic / generate-then-verify (adversarial check before committing).
- Pipeline vs. single mega-agent — why splitting helps (context, focus, testability).
- Loop-until-done vs. fixed stages.
- Routing / triage (cheap model classifies, expensive model handles).

## 3. Rules for individual agents

- One agent, one job. Narrow scope = predictable behaviour.
- Keep context small and relevant — long context degrades, costs more, hides the signal.
- Explicit stop conditions; don't let it spin.
- Make the agent state its plan, then act (steerable, auditable).
- Give it an escape hatch ("if you can't, say so") instead of forcing a guess.
- Least privilege: only the tools it needs for *this* job.

## 4. Tool design

- Tools are the agent's API — design them like one.
- Token efficiency: terse, structured returns; paginate / truncate big outputs; don't
  dump raw blobs into context.
- Determinism: same input → same output where possible; push variability out of the tool.
- Good errors: actionable messages the model can recover from (backpressure).
- Validation at the boundary — reject bad args, don't let the model corrupt state.
- Naming + descriptions matter; the schema *is* the prompt for the tool.
- Idempotency / safety for anything with side effects.

## 5. Conditions for a good pipeline

- Observability: log every step — prompts, tool calls, outputs. You can't fix what you
  can't see.
- Replicability: deterministic, re-runnable; capture inputs so a run can be replayed.
- Checkpointing / resumability — don't redo expensive work on failure.
- Isolation of side effects; clear blast radius per stage.
- Backpressure and rate/cost limits between stages.

## 6. Testing

- Evals are the unit tests of agents — without them you're flying blind.
- Fixtures: recorded conversations / tool transcripts; replay them.
- Test tools deterministically in isolation (they're just functions).
- LLM-as-judge for fuzzy outputs; know its failure modes.
- Regression suite over real past failures.
- Adversarial / red-team: try to break safety & liveness guarantees.

---

## Loose ends / maybe

- Cost & token budgeting as a first-class concern.
- Prompt/version management across a fleet of agents.
- Where a hands-on exercise fits (build a fan-out research agent? a tool with validation?).

---

## Authoritative / popular sources (standard pattern taxonomies)

Three sources to anchor the deck. Use the shared vocabulary so attendees can map our
material onto what they'll read elsewhere.

### Anthropic — "Building Effective Agents" (anthropic.com/engineering)

The canonical taxonomy. Worth adopting wholesale.

- **Building block:** the *augmented LLM* (model + retrieval + tools + memory).
- **Key distinction:** *workflows* (LLMs orchestrated through fixed, predefined code
  paths) vs. *agents* (LLM dynamically directs its own process and tool use).
- **Five workflow patterns:**
  1. Prompt chaining — sequential steps, with programmatic "gates" between them.
  2. Routing — classify input, send to a specialized path / model.
  3. Parallelization — *sectioning* (independent subtasks) and *voting* (same task N
     times for confidence). → our topic 2 "fan-out".
  4. Orchestrator–workers — central LLM decomposes & delegates dynamically, then
     synthesizes. (Subtasks NOT predetermined — that's the difference from sectioning.)
  5. Evaluator–optimizer — one LLM generates, another critiques in a loop. → topic 6 +
     actor–critic.
- **Principles:** simplicity, transparency (show the plan), well-documented + tested
  tools ("ACI" = agent–computer interface). Start simple; only add complexity when it
  earns its keep. → maps to topics 1, 3, 4.
- **Tool design tips:** give room to reason before acting, keep formats close to natural
  text, avoid formatting overhead, include examples/edge cases, "poka-yoke" (make
  mistakes hard). → topic 4.

### OpenAI — "A Practical Guide to Building Agents" (~30pp PDF)

Product/eng framing; good for the "when and how" of single vs. multi-agent.

- **Agent = model + tools + instructions** (the three components). → topic 1, 3.
- **Tool categories:** *data* (retrieve/query), *action* (write/do), *orchestration*
  (other agents as tools). → topic 4.
- **Instructions:** objectives + success criteria, constraints, format/tone, escalation
  thresholds. → topic 3.
- **When to build an agent:** complex judgment, unwieldy rule sets, heavy unstructured
  data — not simple repetitive automation. → topic 1.
- **Orchestration patterns:** single-agent (start here) → *manager* pattern (coordinator
  delegates to specialists, "agents as tools") → *decentralized / handoff* pattern
  (agents pass control). → topic 2.
- **Guardrails:** layered checks, human approval for high-stakes actions, audit trails,
  graceful degradation. → topics 4, 5.

### Victor Dibia — "Designing Multi-Agent Systems" (2025, 15 ch.)

Builds a framework from scratch (`picoagents`); deepest on multi-agent + production.

- **Frame:** agentic systems as *computational graphs*.
- **Deterministic workflow patterns:** sequential, parallel, supervisor. → topic 2, 5.
- **Autonomous orchestration patterns:** plan-based, handoff, conversation-driven
  (predictability ↔ flexibility trade-off). → topic 2.
- **Named multi-agent patterns:** round-robin, Magentic-One. → topic 2.
- **Agent building blocks:** model clients, memory (+ agentic memory), tools, structured
  output, human input, agents-as-tools, observability. → topics 3, 4, 5.
- **Whole chapters on** evaluation/optimization/testing and production (security,
  ethics). → topics 5, 6.

### Cross-source convergence (the "standard" patterns to teach)

- Reflection / evaluator–optimizer / actor–critic (same idea, 3 names).
- Routing.
- Parallelization / fan-out (sectioning + voting).
- Orchestrator–workers / manager / supervisor.
- Handoffs / decentralized control.
- Prompt chaining / sequential deterministic workflow.
- Everyone agrees: **start with the simplest thing; one agent + good tools beats a
  multi-agent maze.**

Source links:
- https://www.anthropic.com/engineering/building-effective-agents
- https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/
  (PDF: https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf)
- https://newsletter.victordibia.com/p/the-designing-multi-agent-systems
  (book: https://www.amazon.com/dp/B0G2BCQQJY)

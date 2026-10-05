# Pi thinking level recommendations

Research date: 2026-10-05. Scope: coding and agentic work in Pi 1.0.2.
No settings changed. Recommendations distinguish API defaults, vendor guidance, and independent evidence.

## Recommended starting points

| Model | Daily coding | Difficult work | Evidence |
|---|---|---|---|
| GPT-6.1 Sol | medium | high; test xhigh | API default medium; Codex says start at the client default. [1][2][3] |
| GPT-6 Astra | low | high; evaluate intermediate levels | Codex explicitly recommends Light, equivalent to low. [2] |
| GPT-5.5 | medium for mixed work; high for complex code | high; test xhigh | General official guidance and a small matched coding experiment. [3][6] |
| Claude Sonnet 4.6 | medium for balance; high for quality-first work | high | API guide recommends medium; Claude Code reverted its medium default after user complaints. [4][5] |
| Claude Sonnet 5.5 | medium for well-specified code | high | Explicit model-specific effort guidance. [4] |
| Claude Opus 5.5 | medium | high | Explicit starting point and API default. [4] |
| Claude Opus 5; Fable/Mythos 5 and 5.1 | high | xhigh | Explicit official guidance; lower levels require task evaluations. [4] |
| Claude Opus 4.7 / 4.8 | xhigh for code | xhigh; max only after measured gains | Coding recommendation differs from API default high. [4] |
| Claude Opus 4.6 | high as a quality-first starting point | high; evaluate max | Claude Code operational guidance; no native xhigh. [4][5] |
| Gemini 3.1 Pro | high for quality-first code | high | Native default high; test medium for routine tasks. [7] |
| Gemini 3.5 Flash | medium | high | Explicit official coding recommendation. [8] |
| Gemini 3.8 Flash | medium | high | Native default medium. [7] |

The daily/difficult columns are a practical synthesis, not a universal vendor guarantee.
Use the exact model's supported levels. Do not transfer effort settings unchanged across model generations.

## Independent and community evidence

### GPT-5.5: matched coding experiment

Stet tested the same 26 Go repository tasks with Codex 0.128.0. [6]

| Effort | Test passes | Reference-equivalent patches | AI review passes | Mean cost/task | Mean duration |
|---|---:|---:|---:|---:|---:|
| medium | 21/26 | 11/26 | 5/26 | $3.13 | 411 seconds |
| high | 25/26 | 18/26 | 10/26 | $4.49 | 579 seconds |
| xhigh | 24/26 | 23/26 | 18/26 | $9.77 | 753 seconds |

High provided a practical quality/cost balance in this experiment. Xhigh improved semantic and review scores but did not improve every metric.
Limitations: 26 tasks, one repository slice, one attempt per task, custom/AI graders, and a commercial benchmark operator.
Do not extrapolate these costs or results to GPT-6.1 Sol or Pi.

### Sonnet 4.6: independent benchmark interpretation

AI Agent Store recommends medium based on a task-weighted interpretation of LiveBench. [9]
Its general-agent-fit scores are low 67.4, medium 72.9, high 72.6.
These are editorial weighted scores, not measured agent success rates.
The underlying LiveBench CSV contains the exact low/medium/high model configurations. [10]
Costs and latency were not measured in this sweep. The small score difference does not prove statistical significance or overthinking.

### First-party operational counterevidence

Anthropic's April 23 postmortem says Claude Code reduced its default from high to medium, then reverted it after quality complaints. [5]
This affected Sonnet/Opus 4.6. The API was not impacted.
Thus Sonnet 4.6 medium is a balanced API recommendation, not proof that it matches high on difficult repository work.
No matched independent effort sweep for GPT-6.1 Sol, current Claude 5.5, or current Gemini coding was established here.

## Pi interpretation

Pi settings accept off, minimal, low, medium, high, xhigh, max.
`defaultThinkingLevel` defaults to medium. `modelThinkingLevels` uses exact provider/modelId keys.
Use `/thinking` to inspect supported choices; Ctrl+S saves the startup level. [11]
Native effort and fixed token budgets are different controls. The same label does not mean the same token count across providers.
Gemini 2.5 uses thinkingBudget in GenerateContent; Gemini 3 uses named levels. [7]
Unsupported levels can be clamped by Pi. Off does not guarantee zero thought on a model that cannot disable it.
The active catalog mapping for openai-codex/gpt-6.1-sol was not independently verified.
Codex Ultra uses subagents; it is not Pi max. OpenAI reasoning.mode pro is separate from reasoning.effort. [2][3]

## Suggested minimal setting

Merge this into the existing settings object; do not replace the file:

```json
{
  "defaultThinkingLevel": "medium",
  "modelThinkingLevels": {
    "openai-codex/gpt-6.1-sol": "medium"
  }
}
```

For a difficult debug task, select high through `/thinking` without changing the startup default.

## Sources

1. https://developers.openai.com/api/docs/models/gpt-6.1-sol
2. https://developers.openai.com/codex/models
3. https://developers.openai.com/api/docs/guides/reasoning.md
4. https://platform.claude.com/docs/en/build-with-claude/effort
5. https://www.anthropic.com/engineering/april-23-postmortem
6. https://www.stet.sh/blog/gpt-55-codex-graphql-reasoning-curve
7. https://ai.google.dev/gemini-api/docs/generate-content/thinking
8. https://ai.google.dev/gemini-api/docs/whats-new-gemini-3.5
9. https://aiagentstore.ai/ai-models/reasoning-effort/claude-sonnet-4-6
10. https://livebench.ai/table_2026_01_08.csv
11. Installed Pi docs: /Users/gordon/.local/lib/node_modules/@earendil-works/pi-coding-agent/docs/settings.md:13-15 and docs/models.md:31.

Primary pages and the Stet evidence were fetched. LiveBench raw data was fetched to verify the Sonnet configuration rows.
Vendor pages are live and may change. Model availability varies by provider, client, and account.

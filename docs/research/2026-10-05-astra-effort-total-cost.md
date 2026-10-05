# Astra effort: whole-task tokens and cost

Research date: 2026-10-05. Settings remain unchanged.

## Finding

Higher effort can reduce whole-task cost, but this is workload-dependent.
ARC Prize directly demonstrates lower Astra xhigh cost than medium in interactive games.
A repeated coding experiment finds the opposite: xhigh processes more total tokens.
Neither finding establishes the optimal effort for GPT-6.1 Sol, Claude Opus 5.5, or Pi.

## Evidence that supports the claim

ARC Prize published its Astra ARC-AGI-3 report on 2026-09-03. [1]
Its exact explanation:

> Higher reasoning levels generally cost less because Astra solves games in fewer actions, reducing the total number of model calls and tokens.

| Harness | Medium score / total cost | Xhigh score / total cost | Cost change |
|---|---|---|---|
| Standard | 38.6% / $48,090 | 59.3% / $37,317 | -22.4% |
| Provider Adapter | 98.4% / $19,285 | 98.4% / $18,147 | -5.9% |

These are aggregate benchmark costs, not prices for one coding task.
The Provider Adapter preserves opaque reasoning state and uses compaction.
The published article does not provide complete raw-token totals for each effort condition.
Thus the table directly establishes a cost reduction; the token-reduction explanation comes from the benchmark authors.
These results concern unfamiliar interactive games, not ordinary repository coding.
Do not combine results across harnesses into one effort comparison.

## Stronger software evidence: DeepSWE

The original machine-readable dataset groups Astra by the same mini-swe-agent harness and effort. [8]
Each effort has 113 tasks and four repetitions: 452 scored attempts.
The dataset was generated on 2026-09-22.

| Effort | Attempt pass rate | Mean total tokens per attempt | Mean cost per attempt | Spend per successful attempt |
|---|---:|---:|---:|---:|
| medium | 72.79% | 1,028,600 | $3.08 | $4.23 |
| high | 73.23% | 1,309,777 | $3.92 | $5.36 |
| xhigh | 74.12% | 1,486,484 | $4.43 | $5.98 |

Calculated total tokens equal mean_input_tokens plus mean_output_tokens.
Calculated spend per successful attempt equals mean_cost_usd divided by pass_at_1, including failed-attempt expenditure.
Against medium, xhigh uses 44.5% more tokens, costs 44.0% more per attempt, and costs 41.4% more per successful attempt.
The 1.33-percentage-point pass-rate increase has overlapping confidence intervals; it does not establish a reliable quality ranking.
Mean steps also increase from 26.03 at medium to 28.75 at xhigh.

Limits: not a Pi study; rollout configurations were not individually audited here.
Provider/verifier/network errors are excluded; timeouts and context-window failures count as failures.
Its current-price cost basis applies at all context lengths, so the dollar values need not match every real provider bill.
Success-adjusted spend is not an adaptive stop-on-success retry experiment or a measure of human-accepted delivery.
The original JSON medium, high, and xhigh rows were directly fetched and checked.

## Evidence against a universal claim

Trilogy ran two engineering tasks three times at each of low, medium, high, and xhigh: 24 runs. [2]
Each run started from a fresh workspace and the same task snapshot, with Codex on ChatGPT Pro.

| Task | Xhigh whole-run tokens relative to medium | Mean duration: medium to xhigh |
|---|---|---|
| Shared staff table refactor | 1.76x | About 14 to 25 minutes |
| Application-wide mobile redesign | 2.52x | About 14 to 38 minutes |

The token totals include accumulated input and cached context, not just generated reasoning.
On the table task, xhigh reduced tool errors from about 10 to fewer than 5, but increased operations from about 66 to 75.
On the mobile task, operations increased from about 63 to 118.
Thus fewer errors did not imply fewer total operations or tokens.

Limits: two tasks, three attempts per condition, internal repository, incomplete browser/device verification, and no blind final quality comparison.
The experiment does not establish equal-quality delivery or success-adjusted cost.
Subscription counters were coarse. The mobile medium runs advanced the weekly counter one point each; xhigh advanced it one, two, and two points.
Raw processed tokens, API cost, and subscription percentage are different metrics.
The article links capture/evaluation software in its EBO repository. [3]

## Additional coding counterexample

Norsica compared Astra low, medium, high and GPT-5.6 Sol high on Galley. [4]
It performed one run per condition for each of analysis, implementation, and review.

| Astra effort | Sum of total tokens | Requests | Estimated API-equivalent cost |
|---|---:|---:|---:|
| medium | 17,234,962 | 141 | $25.67 |
| high | 24,192,717 | 186 | $37.23 |

High produced the strongest implementation, but used about 40% more tokens and cost about 45% more.
These totals sum separate tasks, not one continuous end-to-end pipeline. Xhigh was not tested.
Limits: one repository, one run per phase, model-assisted and non-blind evaluation, no subsequent repair costs.

## Origin of the community claim

Trilogy links an original Reddit account that reports 122 responses at medium versus 65 at xhigh. [5]
The reported effect concerns subscription-quota consumption and repeated large histories.
The account is a plausible hypothesis, not a verified matched-task token experiment in this survey.
The original Reddit page was not independently fetched here.
A secondary synthesis points to both ARC Prize and coding counterexamples. [6]
Use its citations to find original evidence; do not count it as an independent experiment.

## Accounting and test criteria

For OpenAI usage objects, whole-task raw tokens equal the sum of input_tokens plus output_tokens across every request.
Reasoning tokens are already a component of output_tokens. Do not add them again. [7]
Cached tokens are already a component of input_tokens. Their billing differs from uncached input.
A lower raw token total does not guarantee a lower bill, because input, cache, and output prices differ.
A lower bill for an unfinished task does not establish efficiency.

Compare the same model, effort conditions, prompt, repository snapshot, tools, and acceptance tests.
Record raw input/output, cached input, API-equivalent cost, calls, elapsed time, success, and repair work.
Repeat across several tasks and trials. Include failed attempts in aggregate cost per successful completion.
Do not infer raw token efficiency from quota consumed per hour: slower runs may simply perform less work per hour.

## Practical recommendation

Treat high/xhigh as candidates for difficult, stateful tasks with expensive wrong turns.
Do not select xhigh solely to save tokens on routine coding: direct repeated coding evidence contradicts that universal claim.
Retain the user's Sol and Opus medium defaults until same-model task evidence justifies a change.

## Sources

1. https://arcprize.org/blog/astra?output=1
2. https://trilogyai.substack.com/p/astra-reasoning-effort-token-usage
3. https://github.com/trilogy-group/engineering-behavior-observatory
4. https://www.norsica.jp/resources/astra-effort-evaluation
5. https://www.reddit.com/r/codex/comments/1wbdcqz/astra_reasoning_usage_theory/
6. https://myeonbong.com/en/gpt-6-astra-xhigh-vs-medium-usage/
7. https://developers.openai.com/api/docs/guides/reasoning.md
8. https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json

ARC Prize, Trilogy, and Norsica pages were directly fetched.
Artificial Analysis comparison page extracted its methodology but not numeric chart values; this report does not cite those unverified values.
A robotics paper at https://arxiv.org/abs/2610.01939 compares harnesses, not effort levels, and is excluded from effort evidence.

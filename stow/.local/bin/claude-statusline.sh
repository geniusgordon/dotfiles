#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')
CWD=$(echo "$input" | jq -r '.workspace.current_dir')
PARENT=$(basename "$(dirname "$CWD")")
DIR=$(basename "$CWD")
TOTAL_COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

# Session-wide cumulative token usage (from /usage command)
TOTAL_INPUT=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
TOTAL_OUTPUT=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
TOTAL_TOKENS=$((TOTAL_INPUT + TOTAL_OUTPUT))

# Colors
BOLD='\033[1m'
DIM='\033[2m'
MAGENTA='\033[35m'
BLUE='\033[34m'
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
RESET='\033[0m'

# Build context percentage with dynamic color
if [ "$USAGE" != "null" ] && [ "$CONTEXT_SIZE" != "null" ] && [ "$CONTEXT_SIZE" != "0" ]; then
  CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
  PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
  # Color based on usage: green < 50%, yellow 50-80%, red > 80%
  if [ "$PERCENT_USED" -lt 50 ]; then
    CONTEXT_COLOR="$GREEN"
  elif [ "$PERCENT_USED" -lt 80 ]; then
    CONTEXT_COLOR="$YELLOW"
  else
    CONTEXT_COLOR="$RED"
  fi
  CONTEXT_INFO="Ctx: ${CONTEXT_COLOR}${PERCENT_USED}%${RESET}"
else
  CONTEXT_INFO="Ctx: ${DIM}0%${RESET}"
fi

# Build git branch info (bold red to match starship.toml)
GIT_BRANCH=""
if git -C "$CWD" rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH=$(git -C "$CWD" --no-optional-locks branch --show-current 2>/dev/null)
  if [ -n "$BRANCH" ]; then
    GIT_BRANCH=" ${BOLD}${RED}${BRANCH}${RESET}"
  fi
fi

# Usage limit based on plan (set via CLAUDE_PLAN env var)
# Options: "pro" (20), "max5x" (100), "max20x" (200)
# Or set CLAUDE_USAGE_LIMIT directly for custom value
PLAN=${CLAUDE_PLAN:-"max5x"}
case "$PLAN" in
  pro)     USAGE_LIMIT=20 ;;
  max5x)   USAGE_LIMIT=100 ;;
  max20x)  USAGE_LIMIT=200 ;;
  *)       USAGE_LIMIT=${CLAUDE_USAGE_LIMIT:-100} ;;
esac

# Format cost with dynamic color
COST_INFO=$(printf "%.2f" "$TOTAL_COST")
LIMIT_INFO=$(printf "%.0f" "$USAGE_LIMIT")

# Cost color: green < 50%, yellow 50-80%, red > 80% of limit
COST_PERCENT=$(echo "$TOTAL_COST $USAGE_LIMIT" | awk '{printf "%.0f", ($1/$2)*100}')
if [ "$COST_PERCENT" -lt 50 ]; then
  COST_COLOR="$GREEN"
elif [ "$COST_PERCENT" -lt 80 ]; then
  COST_COLOR="$YELLOW"
else
  COST_COLOR="$RED"
fi

# Format usage info (convert to K for readability)
if [ "$TOTAL_TOKENS" -gt 0 ]; then
  TOKENS_K=$(echo "$TOTAL_TOKENS" | awk '{printf "%.1fK", $1/1000}')
  USAGE_INFO=" | ${DIM}Usage: ${RESET}${BLUE}${TOKENS_K}${RESET}${DIM} (${TOTAL_INPUT}↑/${TOTAL_OUTPUT}↓)${RESET}"
else
  USAGE_INFO=""
fi

# Output: [Model] cyan(parent/dir) bold red(branch) | Ctx: X% | $X.XX/$XXX | Usage: XK (input↑/output↓)
# Directory: cyan (starship default), Git branch: bold red (from starship.toml)
echo -e "[${BOLD}${YELLOW}${MODEL}${RESET}] ${CYAN}${PARENT}/${DIR}${RESET}${GIT_BRANCH} | ${CONTEXT_INFO} | ${COST_COLOR}\$${COST_INFO}${RESET}${DIM}/\$${LIMIT_INFO}${RESET}${USAGE_INFO}"

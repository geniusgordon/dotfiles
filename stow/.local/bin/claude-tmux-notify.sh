#!/usr/bin/env bash
set -e

# Fail silently if not in tmux or commands unavailable
S=$(tmux display-message -p '#S' 2>/dev/null) || exit 0
W=$(tmux display-message -p '#I' 2>/dev/null) || exit 0

case "$(uname -s)" in
Darwin)
  # macOS: terminal-notifier
  if command -v terminal-notifier >/dev/null 2>&1; then
    terminal-notifier \
      -title "Claude" \
      -subtitle "Session: $S" \
      -message "Window $W is ready!" \
      -sound "default" \
      >/dev/null 2>&1 || true
  fi
  ;;
Linux)
  # Linux: notify-send
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "Claude" "Session: $S — Window $W is ready!" --icon=utilities-terminal \
      >/dev/null 2>&1 || true
  fi
  ;;
esac

exit 0

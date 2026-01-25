#!/usr/bin/env bash

S=$(tmux display-message -p '#S')
W=$(tmux display-message -p '#I')

case "$(uname -s)" in
  Darwin)
    # macOS: terminal-notifier
    terminal-notifier -title "Claude" -subtitle "Session: $S" -message "Window $W is ready!" -sound "default"
    ;;
  Linux)
    # Linux: notify-send (libnotify) - works with GNOME, KDE, etc.
    notify-send "Claude" "Session: $S — Window $W is ready!" --icon=utilities-terminal
    ;;
esac

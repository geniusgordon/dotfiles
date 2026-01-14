S=$(tmux display-message -p '#S')
W=$(tmux display-message -p '#I')

terminal-notifier -title "Claude" -subtitle "Session: $S" -message "Window $W is ready!" -sound "default"

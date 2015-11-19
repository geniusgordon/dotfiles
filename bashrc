#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/bin/virtualenvwrapper.sh

# tmux
if [[ -z "$TMUX" ]]; then
	# get the id of a deattached session
	ID="`tmux ls | grep -vm1 attached | cut -d: -f1`"
	if [[ -z "$ID" ]]; then # if no available session
		tmux new-session
	else
		tmux attach-session -t "$ID"
	fi
fi


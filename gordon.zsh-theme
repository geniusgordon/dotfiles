local ret_status="%n"
PROMPT='${ret_status} %{$fg[cyan]%}%2c%{$reset_color%} $(git_prompt_info)'
RPROMPT='%{$fg[red]%}%D{%m/%f} %D{%H:%M:%S}%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]$FX[italic]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

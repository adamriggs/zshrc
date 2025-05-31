source $(brew --prefix nvm)/nvm.sh

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && \. "/usr/local/opt/nvm/etc/bash_completion"PATH=$(pyenv root)/shims:$PATH
PATH=$(pyenv root)/shims:$PATH

# 
# COLORS
#
autoload -U colors && colors
export PS1="%F{214}%K{000}%m%F{015}%K{000}:%F{039}%K{000}%~%F{015}%K{000}\$ "

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# 
# PROMPT
#
parse_git_branch() {
  local branch=$(git branch 2>/dev/null | sed -e '/^\*/!d' -e 's/* \(.*\)/\1/')
  local dirty=$(git status --porcelain 2>/dev/null | grep "^[^ ]" | wc -l | tr -d ' ')

  if [[ -n "$branch" ]]; then
    if [[ "$dirty" -gt 0 ]]; then
      echo " ($branch *)"
    else
      echo " ($branch)"
    fi
  fi
}

setopt PROMPT_SUBST
PROMPT='%F{123}%K{000}%m%F{015}%K{000}:%F{039}%K{000}%~%F{141}%}$(parse_git_branch)%{%F{none}%} $ '

#
# ALIASES FOR COMMANDS
#
alias ls='ls -AlGp'
alias local="cd ~/Local\ Sites"
alias 829="cd ~/Documents/work/829"

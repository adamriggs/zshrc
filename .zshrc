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
  local branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
#   local dirty=$(git status --porcelain=1 --untracked-files=all 2>/dev/null | grep -c "^[^ ]")
  local dirty=$(git status --porcelain | grep -c "^[ MARC]")

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
alias ls='ls -Alp'						# sets ls to automatically list all files except . and .. with both permissions and a trainling slash for directories
alias local="cd ~/Local\ Sites"			# easy way to get to the ~/Local Sites directory
alias 829="cd ~/Documents/work/829"		# easy way to get to the other 829 client files that aren't local websites
alias largestfiles="find . -type f -exec ls -l {} + | sort -k5 -nr | head -n 10"	# finds the top 10 largest files recursively in the pwd
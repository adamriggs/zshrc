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
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    local dirty=$(git status --porcelain 2>/dev/null | grep -c "^[ MARC]")

    if [[ -n "$branch" ]]; then
      if [[ "$dirty" -gt 0 ]]; then
        echo " ($branch *)"
      else
        echo " ($branch)"
      fi
    fi
  fi
}

setopt PROMPT_SUBST
PROMPT='%F{123}%K{000}%m%F{015}%K{000}:%F{039}%K{000}%~%F{141}%}$(parse_git_branch)%{%F{none}%} $ '

#
# COMMANDS
#
alias ls='ls -Alp'						# sets ls to automatically list all files except . and .. with both permissions and a trainling slash for directories
alias localsites="cd ~/Local\ Sites"	# easy way to get to the ~/Local Sites directory
alias 829="cd ~/Documents/work/829"		# easy way to get to the other 829 client files that aren't in local sites
alias reloadz="source ~/.zshrc"			# reload this script

# finds the wp-content/themes directory inside of the pwd and cd's into it
function themes() {
  local dir
  dir=$(find . -type d -name themes -path "*/wp-content/themes" -print -quit 2>/dev/null)

  if [[ -n "$dir" && -d "$dir" ]]; then
    cd "$dir" || echo "Found path but failed to cd into: $dir"
  elif [[ -z "$dir" ]]; then
    echo "No wp-content/themes directory found."
  else
    echo "Invalid directory found: '$dir'"
  fi
}

# finds the top 20 largest files recursively in the pwd and outputs their size and path
# optionally provide a path as an argument - this is great to use on ~/Documents to find what's using up all your harddrive space
function largestfiles() {
  local dir="${1:-.}"
  echo -e "🔍 Largest files in: \033[1m$dir\033[0m\n"
  find "$dir" -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 20 | column -t
}

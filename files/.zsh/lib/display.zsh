## Setup colour schemes
if [[ -x $(which dircolors) ]] then
  if [[ -f ~/.dir_colors ]] then
    eval $(dircolors -b ~/.dir_colors)
  elif [[ -f /etc/DIR_COLORS ]] then
    eval $(dircolors -b /etc/DIR_COLORS)
  fi
fi

# grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='38;5;108'

# Setup the ls color option depending on Linux or BSD version ls
ls --color -d . &>/dev/null 2>&1 && alias ls='ls -F --color=auto' || alias ls='ls -FG'

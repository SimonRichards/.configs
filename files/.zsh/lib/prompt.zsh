setup_vcs_info () {
  autoload -Uz vcs_info
  local vcs="$PR_GREEN%s"
  local branch="$PR_BLUE : $PR_YELLOW%b"
  local lights="%c%u"
  local action="$PR_BLUE | $PR_RED%a"

  local branch_format="%r"
  local vcs_prompt="${vcs}${branch}$PR_NO_COLOUR"
  local vcs_action_prompt="${vcs}${branch}${action}$PR_NO_COLOUR"
  local vcs_path="$PR_MAGENTA%R/$PR_GREEN%S$PR_NO_COLOUR"

  local staged_str="${PR_YELLOW}● $PR_NO_COLOUR"
  local unstaged_str="${PR_RED}●  $PR_NO_COLOUR"

  zstyle ':vcs_info:*:prompt:*'     check-for-changes true
  zstyle ':vcs_info:*:prompt:*'     stagedstr         $staged_str
  zstyle ':vcs_info:*:prompt:*'     unstagedstr       $unstaged_str
  zstyle ':vcs_info:*:prompt:*'     branchformat      $branch_format
  zstyle ':vcs_info:*:prompt:*'     formats           $vcs_prompt        $vcs_path $lights
  zstyle ':vcs_info:*:prompt:*'     actionformats     $vcs_action_prompt $vcs_path $lights
  zstyle ':vcs_info:*:prompt:*'     nvcsformats       ""                 "%~"      ""
}

setup_colours () {
  autoload colors zsh/terminfo
  colors

  for colour in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE BLACK; do
    eval PR_$colour='%{$fg[${(L)colour}]%}'
    eval PR_BG_$colour='%{$bg[${(L)colour}]%}'
  done

  PR_NO_COLOUR="%{$terminfo[sgr0]%}"
}

#function zle-line-init zle-keymap-select {
#  VIMODE="${${KEYMAP/vicmd/$PR_YELLOW--}/(main|viins)/$PR_WHITE-/}"
#  zle reset-prompt
#}
#
#zle -N zle-line-init
#zle -N zle-keymap-select

setup_prompt () {
  setopt prompt_subst

  local start_first=""
  local user="%(!.$PR_RED.$PR_GREEN)%n"
  local host="$PR_GREEN%m"
  local whoami="${user}$PR_WHITE at ${host}$PR_NO_COLOUR$PR_BLUE"
  local fill='${(e)PR_FILLBAR}'
  local dir='${(%):-%${PR_PWDLEN}<...<${${${vcs_info_msg_1_}/$HOME/~}/%\/$PR_GREEN\.$PR_NO_COLOUR/$PR_NO_COLOUR}%<<}'
  local whereami="${dir}$PR_BLUE"
  local end_first="$PR_NO_COLOUR"

  local start_second=""
  local time='%D{%H:%M}'
  local return_value='${(%l:3:):-%?}'
  local extra_info="%(?.$PR_CYAN${time}. $PR_RED${return_value}!)"
  local marker="${VIMODE}→"
  local end_second="$PR_NO_COLOUR"

  PROMPT="
${start_first}${whoami}    ${fill}${whereami}${end_first}
${start_second}${extra_info} ${marker} ${end_second}"
}

setup_rprompt () {
  local start=' $PR_BLUE'
  local vcs_string='$vcs_info_msg_0_'
  local end='$PR_NO_COLOUR '

  RPROMPT="${start}${vcs_string}${end}"
}

setup_ps2 () {
  local start=""
  local continuation="$PR_BLUE($PR_GREEN%_$PR_BLUE)"
  local marker="%(!.$PR_RED!.)$PR_BLUE ->"
  local end="$PR_NO_COLOUR "

  PS2="${start}${continuation}${marker}${end}"
}

setup_colours
setup_vcs_info
setup_prompt
setup_rprompt
setup_ps2

#usage: title short_tab_title looooooooooooooooooooooggggggg_windows_title
#http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
#Fully support screen, iterm, and probably most modern xterm and rxvt
#Limited support for Apple Terminal (Terminal can't set window or tab separately)
function title {
  if [[ "$TERM" == "screen" ]]; then 
    print -Pn "\ek$1\e\\" #set screen hardstatus, usually truncated at 20 chars
  elif [[ ($TERM =~ "^xterm") ]] || [[ ($TERM == "rxvt") ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    print -Pn "\e]2;$2\a" #set window name
    print -Pn "\e]1;$1\a" #set icon (=tab) name (will override window name on broken terminal)
  fi
}

precmd () {
  title "%m: %15<..<%~%<<" "%m: %~"
  vcs_info 'prompt'

  ## Setup the path length for the prompt
  local TERMWIDTH
  (( TERMWIDTH = ${COLUMNS} - 1 ))

  PR_FILLBAR=""
  PR_PWDLEN=""

  local prompt="%n at %m     "
  local promptsize=${#${(%)prompt}}
  local pwdsize=${#${(%):-%~}}

  if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
    (( PR_PWDLEN = $TERMWIDTH - $promptsize ))
  else
    PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize))).. .)}"
  fi
}

function preexec {
  local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]} #cmd name only, or if this is sudo or ssh, the next cmd
  title "%m: $CMD" "%m: %100>...>$2%<<"
}


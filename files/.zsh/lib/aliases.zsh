## My custom aliases
alias cd..='cd ..'
alias ls='ls -h'
alias ll='ls -l'
alias lal='ls -al'
alias sizes='gdu -hs ./* | gsort -hr | head'
alias pwd='dirs -v'
alias man=run-help
alias valias=vim ~/.configs/files/.zsh/lib/aliases.zsh

if [[ -x $(which sudo) ]] alias fu='sudo $( fc -ln -1 )'

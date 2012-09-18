## Set colour term if in gnome-terminal
if [[ "$COLORTERM" == "gnome-terminal" ]] then
  export TERM='xterm-256color'
fi

## Source all the config files.
for config_file ($HOME/.zsh/lib/*.zsh)
  source $config_file

extra_config_files=(
  $HOME/.zsh/vendor/syntax-highlighting/zsh-syntax-highlighting.zsh
  $HOME/.zsh/lib/pc-specific/$(hostname).zsh
  $HOME/.zsh/lib/os-specific/$(uname).zsh
)

for config_file in $extra_config_files
  [[ -s $config_file ]] && source $config_file

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export MONO_ROOT=/usr
export MONO_INCLUDE=/usr/include/mono-2.0
export MONO_LIBNAME=mono-2.0

disable r

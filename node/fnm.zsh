# Fast Node Manager - https://github.com/Schniz/fnm
if (( $+commands[fnm] )); then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

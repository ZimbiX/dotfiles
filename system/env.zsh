if (( $+commands[vim] )); then
  export EDITOR=vim
elif (( $+commands[vi] )); then
  export EDITOR=vi
elif (( $+commands[nano] )); then
  export EDITOR=nano
fi

if (( $+commands[google-chrome-stable] )); then
  export BROWSER=google-chrome-stable
fi

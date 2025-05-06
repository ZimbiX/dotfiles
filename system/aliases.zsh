# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if (( $+commands[eza] )); then
  ls_bin="eza"
else
  ls_bin="ls"
fi

# Dotfiles
# ----------------------------------------------------------

alias dfu="~/.dotfiles/script/update"

# Shell
# ----------------------------------------------------------

#alias '#'=':||' # Replace hash with universal comment for zsh compatibiliy (use "# foo")
setopt interactivecomments

# Directory listing
# ----------------------------------------------------------

alias ls="$ls_bin"

if (( $+commands[eza] )); then
  alias l="eza -alF --icons --colour-scale --header --git -g"
else
  alias l="ls -alF --color"
fi

alias llp="list-all-files-with-numeric-premissions"

# Navigation
# ----------------------------------------------------------

alias '..1'='cd ../'
alias '..'='..1'

alias '..2'='cd ../../'
alias '...'='..2'

alias '..3'='cd ../../../'
alias '....'='..3'

alias '..4'='cd ../../../../'
alias '.....'='..4'

alias '..5'='cd ../../../../../'
alias '......'='..5'

alias '..6'='cd ../../../../../../'
alias '.......'='..6'

alias '..7'='cd ../../../../../../../'
alias '........'='..7'

# Programs
# ----------------------------------------------------------

alias als='alsamixer'

alias hideme='history -d $((HISTCMD-1))' # Or just prefix a command with a space =P
alias hideprev='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'

alias gooch='google-chrome'
alias gcgpu='google-chrome-with-gpu'

alias cp0='crashplan-stop'
alias cp1='crashplan-start'

alias sr=set-best-screen-resolution

inspect-jq() { x=$(</dev/stdin); echo "$x" | jq -C . > /dev/tty; echo "$x"; }

aussie-broadband() {
  curl -s https://myaussie-api.aussiebroadband.com.au/customer -b myaussie_cookie="$AUSSIE_BROADBAND_TOKEN"
}
ip-home() {
  aussie-broadband | jq -r '.services.NBN[] | select(.nbnDetails.product != "HFC").ipAddresses[0]'
}

# Cache sudo credentials indefinitely
sudos() {
  # shellcheck disable=SC2034
  sudo -v &&
  SUDOS_RUNNING=true &&
  while :; do
    sleep 60
    sudo -nv 2>/dev/null
  done &
  disown
}

alias h1=heater-on
alias h0=heater-off

if [[ "$TERM" == xterm-kitty ]]; then
  alias ssh='kitty +kitten ssh'
  alias icat='kitty icat --align=left --background="#fff"'
fi

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  ls_bin="gls"
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

alias ls="$ls_bin -F --color"
alias llb="$ls_bin -lA --color"
alias l="llb -h"
alias ll="l"
alias la="$ls_bin -A --color"

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

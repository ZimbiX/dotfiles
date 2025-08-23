[[ -f ~/.ssh_agent ]] && . ~/.ssh_agent >/dev/null

# ssh-init is for systems where keys aren't loaded automatically, which is pretty much just Termux
ssh-init() {
  ssh-agent > ~/.ssh_agent
  . ~/.ssh_agent
  ssh-add
}

alias k='log_and_run_command kubectl'

alias kg='k get'
alias kgp='kg pod'
alias kgd='kg deployment'
alias kgn='kg node'
alias kgs='kg secret'
alias kgi='kg ingress'

alias kd='k describe'
alias kdp='kd pod'
alias kdd='kd deployment'
alias kdn='kd node'
alias kds='kd secret'
alias kdi='kd ingress'

alias ke='k exec -it'

alias ktp='k top pod --sort-by=cpu'

alias kl='k logs'

ksdr() {
  k scale deployment "$1" --replicas="$2"
}

kgsd() {
  kgs -ojson "${1?secret name required}" | ruby -r yaml -r base64 -e 'puts YAML.load(STDIN.read)["data"].transform_values{|v|Base64.decode64(v)}.to_yaml'
}
alias kgsddb='kgsd database-credentials'

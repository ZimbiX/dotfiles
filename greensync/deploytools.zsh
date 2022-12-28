#!/bin/bash

# add-docker-rc() {
#   local with_deploytools
#   with_deploytools=$(grep -r -P '(?<=deploytools:)[^\{\$][^ "]+' -l)
#   | xargs grep .docker-rc.d -L | xargs -r -t perl -i -pe 's%^( +)(-w /work \\)%\1\2\n\1-v ~/.docker-rc.d/:/.docker-rc.d/:ro \\%g'
# }

# add-docker-deploytools-home-cache() {
#   grep -r -P '(?<=deploytools:)[^\{\$][^ "]+' -l | xargs grep deploytools-home-cache:/root -L | xargs -r -t perl -i -pe 's%^( +)(-w /work \\)%\1\2\n\1-v deploytools-home-cache:/root \\%g'
# }



add-docker-rc() {
  grep -r -P '(?<=deploytools:)[^\{\$][^ "]+' -l | xargs grep .docker-rc.d -L | xargs -r -t perl -i -pe 's%^( +)(-w /work \\)%\1\2\n\1-v ~/.docker-rc.d/:/.docker-rc.d/:ro \\%g'
}

# Makes sure my Docker dotfiles get loaded in non-interactive mode too
wd() {
  # add-docker-deploytools-volumes
  add-docker-rc
  ruby -r shellwords -e '
    if ARGV.length == 0
      c = "bash"
    else
      a = ARGV.shelljoin
      b = "BASH_ENV=/root/.bashrc\ " + ["bash", "-c", a].shelljoin
      c = ["bash", "-c", b].shelljoin
    end
    x = ["./auto/with-deploytools", c].join(" ")
    puts "\e[34m--> " + x + "\e[39m"
    system x
  ' "$@"
}

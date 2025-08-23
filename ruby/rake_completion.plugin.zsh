# From: https://github.com/unixorn/rake-completion.zshplugin/blob/master/rake_completion.plugin.zsh
# Which was from: http://weblog.rubyonrails.org/2006/3/9/fast-rake-task-completion-for-zsh/

_rake() {
  if [ -f Rakefile ]; then
    if [[ ! -f .rake_tasks || Rakefile -nt .rake_tasks ]]; then
      bin/rake --silent -AT 2>/dev/null | cut -d " " -f 2 > .rake_tasks
    fi
    compadd $(cat .rake_tasks)
  fi
}

compdef _rake rake

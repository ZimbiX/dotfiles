alias sc='script/console'
alias sg='script/generate'
alias sd='script/destroy'

alias bi='bundle install'
alias be='bundle exec'
alias bu='bundle update'

alias bers='bundle exec rails s'
alias berc='bundle exec rails c'
alias bets='bundle exec thin start'
alias besh='bundle exec shotgun'

gem-browse-source-url() {
  (
    set -Eeuo pipefail

    local gem_info source_url
    gem_info=$(curl -sSNf "https://rubygems.org/api/v1/gems/$1.json")
    source_url=$(echo "$gem_info" | tr -d '\n' | jq -r .source_code_uri)
    if [[ $source_url == null || $source_url == "" ]]; then
      source_url=$(echo "$gem_info" | tr -d '\n' | jq -r .homepage_uri)
    fi
    echo "$source_url"
    open "$source_url" &>/dev/null
  )
}
alias gemb=gem-browse-source-url

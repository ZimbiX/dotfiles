autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

local lc=$'\e[' rc=m bold="01;" # Standard ANSI terminal escape values

typeset -Ag bright_colour fg_bright_bold
bright_colour=(
  black   90
  red     91
  green   92
  yellow  93
  blue    94
  magenta 95
  cyan    96
  white   97
)
fg_bright_bold=(
  black   "$lc$bold$bright_colour[black]$rc"
  red     "$lc$bold$bright_colour[red]$rc"
  green   "$lc$bold$bright_colour[green]$rc"
  yellow  "$lc$bold$bright_colour[yellow]$rc"
  blue    "$lc$bold$bright_colour[blue]$rc"
  magenta "$lc$bold$bright_colour[magenta]$rc"
  cyan    "$lc$bold$bright_colour[cyan]$rc"
  white   "$lc$bold$bright_colour[white]$rc"
)

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg_bright_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bright_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bright_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] )); then
    echo "$(rbenv version | awk '{print $1}')"
  elif (( $+commands[asdf] )); then
    echo "$(asdf current --no-header ruby | awk '{print $2}')"
  fi
}

rb_prompt() {
  local version
  version="$(ruby_version)"
  if ! [[ -z "$version" ]]
  then
    echo "%{$fg_bright_bold[yellow]%}$version%{$reset_color%} "
  else
    echo ""
  fi
}

gcloud_prompt() {
  local cyan="\e[36m"
  echo "${cyan}$(gcloud-project --current 2>&1)${reset_color}"
}

# https://github.com/jonmosco/kube-ps1
if [ -f "$PROJECTS/kube-ps1/kube-ps1.sh" ]; then
  . "$PROJECTS/kube-ps1/kube-ps1.sh"
  KUBE_PS1_PREFIX=''
  KUBE_PS1_SUFFIX=''
  KUBE_PS1_SYMBOL_ENABLE=false
  KUBE_PS1_CTX_COLOR=32

  get_cluster_short() {
    echo "$1" | sed -E 's/.+_//'
  }

  KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
else
  kube_ps1() {}
fi

directory_name() {
  echo "%{$fg_bright_bold[cyan]%}%1/%\/%{$reset_color%}"
}

sudos_prompt() {
  if sudo -nv 2>/dev/null; then
    if [[ -n "$SUDOS_RUNNING" ]]; then
      echo " %{$fg_bright_bold[yellow]%}su+%{$reset_color%}"
    else
      echo " %{$fg_bright_bold[yellow]%}su%{$reset_color%}"
    fi
  fi
}

disk_remaining() {
  local disk
  if [[ $(uname -a) == *" Android" ]]; then
    fs=/storage/emulated
  else
    fs=/
  fi
  df -kh "$fs" | grep -E '^Filesystem +Size +Used +Avail ' >/dev/null || echo "Warning: df headers are unexpected - free disk space in prompt may be wrong" >&2
  df -kh "$fs" | tail -1 | awk '{ print $4 }' | tr -d '\ni' && printf B
}

hostname_if_ssh() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo -n "%{$fg_bold[green]%}"
    hostname | tr -d "\n"
    echo -n "%{$reset_color%}"
    echo -n :
  fi
}

exit_code_prompt() {
  if [[ "$last_exit_code" == "0" ]]; then
    local exit_code_prompt_colour="%{$fg_bright_bold[green]%}"  # "%F{10}" #"$lc%{$(($color[green]+8))%}"
  else
    local exit_code_prompt_colour="%{$fg_bright_bold[red]%}"
  fi
  echo "${exit_code_prompt_colour}➜ %{$reset_color%}"
}

if [[ "$SIMPLE_PROMPT" == 'true' ]]; then
  export PROMPT=""
else
  export PROMPT=$'\n$(rb_prompt)in $(hostname_if_ssh)$(directory_name) $(git_dirty)$(need_push)\n$(gcloud_prompt) $(kube_ps1) $(disk_remaining) - $(date)$(sudos_prompt)'
  # if typeset -f dex-env-shell-prompt > /dev/null; then
  #   export PROMPT="$PROMPT"$'\n$(dex-env-shell-prompt)'
  # fi
fi
export PROMPT="$PROMPT"$'\n$(exit_code_prompt)'
set_prompt () {
  export RPROMPT="%{$fg_bright_bold[cyan]%}%{$reset_color%}"
}

set_title() {
  # Use the current path (with standard ~ replacement) in square brackets as the prefix of the tab title
  local tab_title_path=$(basename $PWD) # Full path: %~
  # When running a command, show the title of the command as the rest of the tab title (truncate to drop the path to the command)
  local tab_title_command=$(echo "$cmd" | sed -E 's/ +/\n/g' | grep -Ev '^[A-Z0-9_]+=' | head -1)
  local tab_title="$tab_title_path"
  if [[ -n "$tab_title_command" ]]; then
    tab_title="$tab_title: $tab_title_command"
  fi
  title "zsh" "$tab_title" "%55<...<%~"
}

# Called by zsh before executing a command
preexec() {
  # Get the full command string
  local -a cmd=(${(z)1})
  set_title
}

# Called by zsh before showing the prompt
precmd() {
  # local lc="$BASH_COMMAND" rc=$?
  # echo "Command [$lc] exited with code [$rc]"
  last_exit_code="$?"
  set_title
  set_prompt
}

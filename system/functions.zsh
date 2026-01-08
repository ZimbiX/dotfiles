log_command() {
  echo -n "\e[34m" >&2
  echo -n '--> ' >&2
  echo -n "${(q)@}" >&2
  echo "\e[39m" >&2
}

log_and_run_command() {
  log_command "$@"
  "$@"
  # { set -x; "$@" }
}

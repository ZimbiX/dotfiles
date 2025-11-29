brup() {
  log_and_run_command brew update -v && \
  log_and_run_command brew upgrade && \
  log_and_run_command brew upgrade --cask --greedy
}

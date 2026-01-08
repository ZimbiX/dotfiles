jira() {
  local jira_issue_number
  jira_issue_number="$(git rev-parse --abbrev-ref HEAD | grep -oE 'ES-\d+')"
  open "https://attainhealthtech.atlassian.net/browse/$jira_issue_number"
}

alias ses='log_and_run_command switch-env stg'
alias sep='log_and_run_command switch-env prd-lw'

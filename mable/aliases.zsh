jira() {
  local jira_issue_number
  jira_issue_number="$(git rev-parse --abbrev-ref HEAD | grep -oE 'ES-\d+')"
  open "https://attainhealthtech.atlassian.net/browse/$jira_issue_number"
}

if [ -f "$PROJECTS/inf-scripts/util/aws-creds" ]; then
  # New version using `prod-access`

  cat "$PROJECTS/inf-scripts/util/aws-creds" \
  | sed -E 's/(^.*Fetching auth details from AWS config)/mac-focus-app kitty; \1/' \
  > "$PROJECTS/inf-scripts/util/aws-creds-zimbix"
  chmod +x "$PROJECTS/inf-scripts/util/aws-creds-zimbix"

  cat "$PROJECTS/inf-scripts/prod-access/prod-access.sh" \
  | sed -E 's/aws-creds/aws-creds-zimbix/g' \
  > "$PROJECTS/inf-scripts/prod-access/prod-access-zimbix.sh"
  source "$PROJECTS/inf-scripts/prod-access/prod-access-zimbix.sh"

  cat "$PROJECTS/inf-scripts/switch-env/switch-env.sh" \
  | sed -E 's/aws-creds/aws-creds-zimbix/g' \
  > "$PROJECTS/inf-scripts/switch-env/switch-env-zimbix.sh"
  source "$PROJECTS/inf-scripts/switch-env/switch-env-zimbix.sh"
else
  # Old version

  if [ -f "$PROJECTS/inf-scripts/switch-env/switch-env.sh" ]; then
    {
      cat "$PROJECTS/inf-scripts/switch-env/switch-env.sh" \
      | sed -E 's/(echo "Fetching auth details from AWS config:")/mac-focus-app kitty; \1/' \
      | sed -E 's/^switch-env\(\) \{$/switch-env-orig() {/' && \
      cat << EOF
switch-env() {
  switch-env-orig "\$@" || return 1
  if [[ "\$1" == prd* ]]; then
    printf "\\n\\e[32mNow run: eks-jumpbox-session\\e[0m\\n"
  else
    printf "\\n\\e[32mNow run: kubectl exec [...]\\e[0m\\n"
  fi
}
EOF
    } > "$PROJECTS/inf-scripts/switch-env/switch-env-zimbix.sh"
    . "$PROJECTS/inf-scripts/switch-env/switch-env-zimbix.sh"
  fi
fi

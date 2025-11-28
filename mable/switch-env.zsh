if [ -f "$PROJECTS/inf-scripts/switch-env/switch-env.sh" ]; then
  {
    cat "$PROJECTS/inf-scripts/switch-env/switch-env.sh" \
    | sed -E 's/(echo "Fetching auth details from AWS config:")/mac-focus-app kitty; \1/' \
    | sed -E 's/^switch-env\(\) \{$/switch-env-orig() {/' &&
    echo 'switch-env() { switch-env-orig "$@" && if [[ "$1" == "prd-lw" ]]; then printf "\n\e[32mNow run: eks-jumpbox-session\e[0m\n"; fi }'; \
  } > "$PROJECTS/inf-scripts/switch-env/switch-env-zimbix.sh"
  . "$PROJECTS/inf-scripts/switch-env/switch-env-zimbix.sh"
fi

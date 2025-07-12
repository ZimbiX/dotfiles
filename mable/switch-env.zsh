if [ -f "$PROJECTS/inf-scripts/switch-env/switch-env.sh" ]; then
  cat "$PROJECTS/inf-scripts/switch-env/switch-env.sh" \
    | sed -E 's/(echo "Fetching auth details from AWS config:")/mac-focus-app kitty; \1/' \
    > "$PROJECTS/inf-scripts/switch-env/switch-env-zimbix.sh"
  . "$PROJECTS/inf-scripts/switch-env/switch-env-zimbix.sh"
fi

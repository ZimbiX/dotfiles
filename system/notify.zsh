# Use the Gnome notification utility if it exists
# https://github.com/vlevit/notify-send.sh
notify-send() {
  if [ -x "$(command -v notify-send.sh)" ]; then
    notify-send.sh "$@"
  fi
}

# Show a success notification on Gnome
notify-success() {
  local title="$1"
  local message="$2"
  local notification_file="/tmp/${3:-notification-file-for-shell-pid-$PPID}"
  notify-send --icon=checkmark --urgency=normal --replace-file="$notification_file" "$title" "$message"
}

# Show an error notification on Gnome
notify-err() {
  local title="$1"
  local message="$2"
  local notification_file="/tmp/${3:-notification-file-for-shell-pid-$PPID}"
  notify-send --icon=error --urgency=normal --replace-file="$notification_file" "$title" "$message"
}

# Dismiss a Gnome notification
notify-clear() {
  local notification_file="/tmp/${1:-notification-file-for-shell-pid-$PPID}"
  if [ -f "$notification_file" ]; then
    notify-send --close="$(cat "$notification_file")"
  fi
}

unalias db
db() {
  (
    set -e
    local services
    services=($(docker compose config --services 2>/dev/null | grep -E '^(db|redis)$'))
    log_and_run_command docker compose up -d "${services[@]}"
    db-wait
  )
}

# Docker restart - necessary after pausing and resuming the VM (which results in the docker0 network losing its IP address)
dr() {
  (
    set -e
    drm || :
    log_and_run_command sudo systemctl restart docker
    db
  )
}

db-wait() {
  mysql-wait
}

mysql-wait() {
  if docker compose config 2>/dev/null | grep 'image: mysql' >/dev/null; then
    echo "Waiting for MySQL to start accepting connections"
    local mysql_command
    mysql_command=$(dotenv sh -c 'echo "mysql -h \"$DB_HOST\" -P \"$DB_PORT\" -u \"$DB_USER_NAME\" -p\"$DB_PWD\" -e \"SELECT 1\""')
    log_command "(loop)" "$mysql_command"
    while ! eval "$mysql_command" &> /dev/null; do printf .; sleep 0.02; done; echo
  fi
}

db-clean() {
  (
    set -e
    log_and_run_command docker compose down
    log_and_run_command docker volume rm -f rto_db-data
    sudo mkdir -p /var/lib/docker/volumes/rto_db-data/_data/
    time sudo sh -c 'cp -r db/volume/clean/* /var/lib/docker/volumes/rto_db-data/_data/'
    db
  )
}

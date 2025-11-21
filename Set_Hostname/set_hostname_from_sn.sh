#!/usr/bin/env bash
set -euo pipefail
# Query an inventory service for the expected hostname tied to this machine's
# serial number, then set the local hostname to match.
BASE_URL="${HOST_LOOKUP_URL:-http://10.254.105.101:8000}" # allow override for testing
log() {
  printf '[hostname-sync] %s\n' "$*" # consistent log prefix
}
fail() {
  printf '[hostname-sync][error] %s\n' "$*" >&2
  exit 1
}
need_cmd() {
  command -v "$1" >/dev/null 2>&1 || fail "Missing required command: $1" # sanity check
}
trim() {
  # shellcheck disable=SC2001
  echo "$*" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}
main() {
  if [[ "$(id -u)" -ne 0 ]]; then
    fail "Run this script as root (dmidecode + hostname changes require elevated privileges)."
  fi
  need_cmd dmidecode
  need_cmd curl
  local serial hostname_url desired_hostname current_hostname
  serial=$(dmidecode -s system-serial-number | head -n1 | tr -d '\r') # BIOS serial
  serial=$(trim "$serial")
  [[ -n "$serial" ]] || fail "Unable to read system serial number."
  hostname_url="${BASE_URL%/}/${serial}/hostname" # final request URL
  log "Fetching hostname for serial ${serial} from ${hostname_url}"
  desired_hostname=$(curl -fsSL --connect-timeout 5 --max-time 10 "$hostname_url" | head -n1 | tr -d '\r')
  desired_hostname=$(trim "$desired_hostname")
  [[ -n "$desired_hostname" ]] || fail "Hostname response was empty."
  current_hostname=$(hostname | tr -d '\r')
  current_hostname=$(trim "$current_hostname")
  if [[ "$current_hostname" == "$desired_hostname" ]]; then
    log "Hostname already set to ${desired_hostname}; nothing to do."
    exit 0
  fi
  log "Changing hostname from ${current_hostname} to ${desired_hostname}"
  if command -v hostnamectl >/dev/null 2>&1; then
    hostnamectl set-hostname "$desired_hostname"
  else
    hostname "$desired_hostname" # legacy util
    printf '%s\n' "$desired_hostname" > /etc/hostname # ensure persistence
  fi
  log "Hostname updated successfully."
}
main "$@"


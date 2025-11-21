#!/usr/bin/env bash
set -euo pipefail
# Download and apply a netplan configuration whose location is derived from
# the machine's hostname. Example target:
#   http://10.254.105.44:8001/<hostname>/00-installer-config.yaml

#trap funtion
check_gw_and_dhcp() {
    local GW="10.254.104.1"
    local IFACE="bond0"
    if ping -c 15 -W 1 "$GW" >/dev/null 2>&1; then
        echo "$(date '+%F %T') - Gateway $GW reachable."
    else
        echo "$(date '+%F %T') - Gateway $GW unreachable, running dhclient on $IFACE..."
        mv /tmp/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml
        mv /etc/netplan/00-installer-config.yaml /tmp/
        netplan apply
    fi
}
# trap check_gw_and_dhcp ERR
BASE_URL="${NETPLAN_BASE_URL:-http://10.254.105.101:8001}"
NETPLAN_FILENAME="${NETPLAN_FILENAME:-00-installer-config.yaml}"
NETPLAN_DEST_PATH="${NETPLAN_DEST_PATH:-/etc/netplan/00-installer-config.yaml}"
log() {
  printf '[netplan-sync-hostname] %s\n' "$*"
}
fail() {
  printf '[netplan-sync-hostname][error] %s\n' "$*" >&2
  exit 1
}
need_cmd() {
  command -v "$1" >/dev/null 2>&1 || fail "Missing required command: $1"
}
main() {
  if [[ "$(id -u)" -ne 0 ]]; then
    fail "Run as root so we can write to ${NETPLAN_DEST_PATH} and apply netplan."
  fi
  need_cmd hostname
  need_cmd curl
  need_cmd install
  local host_name netplan_url tmp_file
  host_name=$(hostname | tr -d '\r')
  [[ -n "$host_name" ]] || fail "Unable to determine hostname."
  log "Detected hostname: ${host_name}"
  netplan_url="${BASE_URL%/}/${host_name}/${NETPLAN_FILENAME}"
  log "Fetching netplan config from ${netplan_url}"
  tmp_file=$(mktemp)
  if ! curl -fsSL --connect-timeout 5 --max-time 20 "$netplan_url" -o "$tmp_file"; then
    rm -f "$tmp_file"
    fail "Failed to download netplan config."
  fi
  mkdir -p "$(dirname "$NETPLAN_DEST_PATH")"
  install -m 600 "$tmp_file" "$NETPLAN_DEST_PATH"
  rm -f "$tmp_file"
  log "Netplan config installed to ${NETPLAN_DEST_PATH}"
  if command -v netplan >/dev/null 2>&1; then
    if netplan apply; then
      log "netplan apply succeeded."
    else
      fail "netplan apply failed; investigate before retrying."
    fi
  else
    log "netplan CLI not found; apply changes manually if needed."
  fi
}
mv /etc/netplan/50-cloud-init.yaml /tmp/ || :
bash /tools/gpu-base-build/renamedev.sh
if [ $? -ne 0 ]; then
    echo "renamedev.sh exit -1, Quit it anymore!!!"
    exit 1
fi
main "$@"
# check_gw_and_dhcp

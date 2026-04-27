#!/bin/bash
# ha_ctrl.sh — Control a Home Assistant switch entity
# Usage: ha_ctrl.sh <on|off|restart> <entity_id> <ha_url> <ha_token>

set -euo pipefail

ACTION="${1:?Usage: $0 <on|off|restart> <entity_id> <ha_url> <ha_token>}"
ENTITY="${2:?Missing entity_id}"
HA_URL="${3:?Missing HA_URL}"
HA_TOKEN="${4:?Missing HA_TOKEN}"

call_ha() {
    local entity="$1"
    local service="$2"
    local http_code
    http_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
        -H "Authorization: Bearer ${HA_TOKEN}" \
        -H "Content-Type: application/json" \
        -d "{\"entity_id\": \"${entity}\"}" \
        "${HA_URL}/api/services/switch/${service}")
    if [[ "$http_code" != "200" ]]; then
        echo "ERROR: HA returned HTTP ${http_code} for ${service} on ${entity}" >&2
        return 1
    fi
}

case "$ACTION" in
    on)
        echo "Turning ON ${ENTITY}..."
        call_ha "$ENTITY" "turn_on"
        echo "Done."
        ;;
    off)
        echo "Turning OFF ${ENTITY}..."
        call_ha "$ENTITY" "turn_off"
        echo "Done."
        ;;
    restart)
        echo "Restarting ${ENTITY} (power cycle: off → on)..."
        call_ha "$ENTITY" "turn_off"
        sleep 3
        call_ha "$ENTITY" "turn_on"
        echo "Done."
        ;;
    *)
        echo "Unknown action: $ACTION" >&2
        echo "Supported: on, off, restart" >&2
        exit 1
        ;;
esac

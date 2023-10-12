
#!/bin/bash

set -e


#RUN_ID="${RUN_ID:-$(date +%Y-%m-%d-%H%M%S)}"
# RUN_ID="2023"
# readonly RUN_ID
# readonly RUN_DIR="/tmp/outline/${RUN_ID}"
# echo "Using directory ${RUN_DIR}"

# readonly HOST_STATE_DIR="${RUN_DIR}/persisted-state"
# readonly CONTAINER_STATE_DIR='/root/shadowbox/persisted-state'
# readonly STATE_CONFIG="${HOST_STATE_DIR}/shadowbox_server_config.json"

# declare -ir ACCESS_KEY_PORT=${ACCESS_KEY_PORT:-9999}
# declare -ir SB_API_PORT=${SB_API_PORT:-8081}

# [[ -d "${HOST_STATE_DIR}" ]] || mkdir -p "${HOST_STATE_DIR}"
# [[ -e "${STATE_CONFIG}" ]] || echo "{\"hostname\":\"70.34.195.107\", \"portForNewAccessKeys\": ${ACCESS_KEY_PORT}}" > "${STATE_CONFIG}"









/opt/outline-server/bin/outline-ss-server "-config" "/root/shadowbox/persisted-state/outline-ss-server/config.yml" "-metrics" "127.0.0.1:9092" "-ip_country_db" "/var/lib/libmaxminddb/ip-country.mmdb" "-verbose" "--replay_history=10000"

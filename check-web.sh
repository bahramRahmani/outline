#!/bin/bash

DURATION=$(</dev/stdin)
if (($DURATION <= 5000)); then
    exit 60
else
    if ! curl --silent --fail qbittorrent-wrapper:5001/webui &>/dev/null; then
        echo "Web interface is unreachable" >&2
        exit 1
    fi
fi

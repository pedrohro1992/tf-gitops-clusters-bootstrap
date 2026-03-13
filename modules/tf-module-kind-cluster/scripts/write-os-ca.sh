#!/usr/bin/env bash
set -euo pipefail

NODE="$1"
CA_FILE="$2"

docker exec -i "${NODE}" \
  tee /usr/local/share/ca-certificates/vault-ca-bundle.crt <"${CA_FILE}" >/dev/null

docker exec "${NODE}" update-ca-certificates

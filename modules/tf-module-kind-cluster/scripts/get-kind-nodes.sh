#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="$1"

nodes=$(docker ps \
  --filter "label=io.x-k8s.kind.cluster=${CLUSTER_NAME}" \
  --format '{{.Names}}' | tr '\n' ',')

nodes="${nodes%,}" # strip trailing comma

echo "{\"nodes\": \"${nodes}\"}"

#!/usr/bin/env bash
set -euo pipefail

NODE="$1"
REGISTRY="$2"
HOSTS_TOML_FILE="$3"

docker exec "${NODE}" \
  mkdir -p "/etc/containerd/certs.d/${REGISTRY}"

docker exec -i "${NODE}" \
  tee "/etc/containerd/certs.d/${REGISTRY}/hosts.toml" <"${HOSTS_TOML_FILE}" >/dev/null

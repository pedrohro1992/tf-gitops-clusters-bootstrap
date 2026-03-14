#!/usr/bin/env bash
set -euo pipefail

NODE="$1"

docker exec "${NODE}" systemctl restart containerd

#!/usr/bin/env bash

set -euo pipefail

STORAGE_PATH="${1}"

if [ -z "${STORAGE_PATH}" ]; then
  echo "[ERROR] STORAGE_PATH not provided"
  exit 1
fi

echo "[INFO] Ensuring storage directory at ${STORAGE_PATH}"

if [ ! -d "${STORAGE_PATH}" ]; then
  echo "[INFO] Creating directory..."
  sudo mkdir -p "${STORAGE_PATH}"
else
  echo "[INFO] Directory already exists."
fi

echo "[INFO] Setting permissions..."
sudo chmod 0777 "${STORAGE_PATH}"

echo "[INFO] Storage ready."

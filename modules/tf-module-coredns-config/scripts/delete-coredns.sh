#!/usr/bin/env bash
set -euo pipefail

echo "Removendo ConfigMap coredns (se existir)..."

kubectl delete configmap coredns \
  -n kube-system \
  --ignore-not-found=true

echo "Finalizado."

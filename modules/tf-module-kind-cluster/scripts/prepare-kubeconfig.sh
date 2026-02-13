#!/bin/bash
set -e 

# Atribuição de parâmetros para variáveis legíveis
WORKLOAD_CLUSTER_NAME=$1
CONTROL_PLANE_CONTEXT=$2

if [ -z "$WORKLOAD_CLUSTER_NAME" ] || [ -z "$CONTROL_PLANE_CONTEXT" ]; then
    echo "❌ Erro: Parâmetros ausentes."
    echo "Uso: ./prepare-kubeconfig.sh [NOME_WORKLOAD] [CONTEXTO_CONTROL_PLANE]"
    exit 1
fi

echo "Step 1: Extraindo kubeconfig de $WORKLOAD_CLUSTER_NAME..."
kind get kubeconfig --name "$WORKLOAD_CLUSTER_NAME" > workload_raw.yaml

echo "Step 2: Ajustando endpoint para comunicação entre containers..."
KIND_NODE_NAME="${WORKLOAD_CLUSTER_NAME}-control-plane"
# Substitui 127.0.0.1 pela rede interna do Docker (DNS do container)
sed "s|server: https://127.0.0.1:.*|server: https://$KIND_NODE_NAME:6443|g" workload_raw.yaml > workload_internal.yaml

echo "Step 3: Injetando Secret no Control Plane (Contexto: $CONTROL_PLANE_CONTEXT)..."
kubectl --context "$CONTROL_PLANE_CONTEXT" create secret generic "${WORKLOAD_CLUSTER_NAME}-auth" \
  --from-file=kubeconfig=workload_internal.yaml \
  -n crossplane-system \
  --dry-run=client -o yaml | kubectl --context "$CONTROL_PLANE_CONTEXT" apply -f -

# Limpeza opcional do arquivo temporário por segurança
rm workload_raw.yaml workload_internal.yaml

echo "✅ Sucesso! O Crossplane no cluster '$CONTROL_PLANE_CONTEXT' agora pode acessar '$WORKLOAD_CLUSTER_NAME'."

#!/bin/bash
# get_kind_ip.sh

# O Terraform passa o nome do cluster como o primeiro argumento
CLUSTER_NAME=$1

# Busca o IP interno do container (o nome do container no Kind é sempre cluster-name + "-control-plane")
KIND_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${CLUSTER_NAME}-control-plane")

# Retorna o JSON com o Host formatado
jq -n --arg ip "$KIND_IP" '{"host": ("https://"+$ip+":6443")}'

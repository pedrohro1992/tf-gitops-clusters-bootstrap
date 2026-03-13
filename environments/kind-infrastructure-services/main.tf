module "kind_infrastructure" {
  source = "../../modules/tf-module-kind-blueprint"

  cluster_name           = "homelab-infrastructure-services"
  pod_network_cidr       = "10.244.0.0/16"
  disable_default_cni    = true
  create_cluster_storage = true
  
  coredns_forward_ip = "172.18.0.14"
  coredns_custom_zone = "cacetinho.internal.infra"

  vault_infra_secret_path = "secret/data/infra"
  vault_addr = "http://vault.cacetinho.internal.infra:8200"

  extra_port_mappings = [
    {
      container_port = 30080
      host_port      = 80
      protocol       = "TCP"
    },
    {
      container_port = 30443
      host_port      = 443
      protocol       = "TCP"
    }
  ]

  nodes = [
    {
      role           = "control-plane"
      enable_storage = false
      labels = {
        ingress-ready = "true"
        platform      = "true"
      }
    },
    {
      role           = "worker"
      enable_storage = true
      labels = {
        workload = "general"
        tier     = "application"
        storage = "enabled"
      }
    },
    {
      role           = "worker"
      enable_storage = true
      labels = {
        workload = "general"
        tier     = "application"
        storage = "enabled" 

      }
    },
    {
      role           = "worker"
      enable_storage = true
      labels = {
        workload = "general"
        tier     = "application"
        storage = "enabled" 

      }
    },
    {
      role           = "worker"
      enable_storage = false
      labels = {
        workload = "general"
        tier     = "application"

      }
    },
    {
      role           = "worker"
      enable_storage = false
      labels = {
        workload = "general"
        tier     = "application"

      }
    },

  ]

}

module "kind_infrastructure" {
  source = "../../modules/tf-module-kind-homelab"

  cluster_name           = "kind-infrastructure-services"
  pod_network_cidr       = "10.244.0.0/16"
  disable_default_cni    = true
  create_cluster_storage = true

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
      enable_storage = true
      labels = {
        ingress-ready = "true"
        platform      = "true"
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
    }
  ]


}

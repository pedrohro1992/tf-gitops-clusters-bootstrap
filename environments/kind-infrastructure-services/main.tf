module "kind_infrastructure" {
  source = "../../modules/tf-module-kind-homelab"

  cluster_name        = "kind-infrastructure-services"
  disable_default_cni = true

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
      role = "control-plane"
      labels = {
        ingress-ready = "true"
        platform      = "true"
      }
    }
  ]


}

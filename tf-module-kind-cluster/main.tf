resource "kind_cluster" "this" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        <<-EOF
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
        EOF
      ]

      dynamic "extra_port_mappings" {
        for_each = var.enable_ingress_ports ? [
        { container = 30080, host = 80 },
        { container = 300443, host = 443 },
        ] : []

        content {
          container_port = extra_port_mappings.value.container
          host_port = extra_port_mappings.value.host
          protocol = "TCP"
        }
      }

    }
  }
}

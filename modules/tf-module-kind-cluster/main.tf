resource "kind_cluster" "this" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    networking {
      disable_default_cni = var.disable_default_cni
      pod_subnet          = var.pod_network_cidr
    }

    dynamic "node" {
      for_each = var.nodes

      content {
        role = node.value.role

        kubeadm_config_patches = [
          <<-EOF
          kind: InitConfiguration
          nodeRegistration:
            kubeletExtraArgs:
              node-labels: "${join(",", [for k, v in node.value.labels : "${k}=${v}"])}"
          EOF
        ]

        dynamic "extra_port_mappings" {
          for_each = (
            node.value.role == "control-plane"
          ) ? var.extra_port_mappings : []

          content {
            container_port = extra_port_mappings.value.container_port
            host_port      = extra_port_mappings.value.host_port
            protocol       = extra_port_mappings.value.protocol
          }
        }

        dynamic "extra_mounts" {
          for_each = node.value.enable_storage ? [{
            host_path      = local.storage_path
            container_path = "/var/openebs"
          }] : []
          content {
            host_path      = extra_mounts.value.host_path
            container_path = extra_mounts.value.container_path
          }
        }

      }
    }
  }

  depends_on = [
    null_resource.create_storage

  ]
}

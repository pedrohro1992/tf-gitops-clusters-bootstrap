resource "null_resource" "register_workload" {

  count = var.is_cluster_data_plane ? 1 : 0
  provisioner "local-exec" {
    command = "${path.module}/scripts/prepare-kubeconfig.sh ${var.cluster_name} ${var.crossplane_control_plane_cluster}"
  }

  depends_on = [kind_cluster.this]
}

data "external" "kubernetes_api_address" {
  program = ["bash", "${path.module}/scripts/get-kind-info.sh", var.cluster_name]
}

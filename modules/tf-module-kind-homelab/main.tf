module "kind_cluster" {
  source       = "../tf-module-kind-cluster"
  cluster_name = var.cluster_name

  disable_default_cni    = var.disable_default_cni
  extra_port_mappings    = var.extra_port_mappings
  nodes                  = var.nodes
  create_cluster_storage = var.create_cluster_storage


}

module "calico" {
  source = "../tf-module-network-calico"

  pod_network_cidr = var.pod_network_cidr

  depends_on = [module.kind_cluster]
}

module "openEBS" {
  source = "../tf-module-storage-OpenEBS"

  depends_on = [module.calico]
}

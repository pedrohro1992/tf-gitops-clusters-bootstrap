module "kind_cluster" {
  source       = "../tf-module-kind-cluster"
  cluster_name = var.cluster_name

  disable_default_cni    = var.disable_default_cni
  extra_port_mappings    = var.extra_port_mappings
  nodes                  = var.nodes
  create_cluster_storage = var.create_cluster_storage

}

module "coreDNS_configMap" {
  cluster_name        = var.cluster_name
  source              = "../tf-module-coredns-config"
  coredns_forward_ip  = var.coredns_forward_ip
  coredns_custom_zone = var.coredns_custom_zone

  depends_on = [module.kind_cluster]
}

module "calico" {
  source = "../tf-module-network-calico"

  pod_network_cidr = var.pod_network_cidr

  depends_on = [module.coreDNS_configMap]
}

module "openEBS" {
  source = "../tf-module-storage-OpenEBS"

  depends_on = [module.calico]
}

module "platform_operator" {
  source       = "../tf-module-platform-operator"
  vault_ca_pem = module.kind_cluster.vault_ca_pem
  ca_tmp_file  = module.kind_cluster.ca_tmp_file
}

module "eso_infra" {
  source                  = "../tf-module-eso-infra"
  cluster_name            = var.cluster_name
  kubernetes_ca_cert      = base64decode(module.kind_cluster.cluster_ca_certificate)
  vault_infra_secret_path = var.vault_infra_secret_path
  vault_addr              = var.vault_addr
}

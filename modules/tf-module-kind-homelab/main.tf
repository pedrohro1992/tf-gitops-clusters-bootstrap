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

# module "argocd" {
#   source = "../tf-module-argocd"
#
#
#   depends_on = [module.control_plane_cluster]
# }
#
# module "crossplane_bootstrap" {
#   source = "../tf-module-crossplane-app"
#
#   git_repo_url  = local.git_repo_url_control_plane
#   git_repo_path = "crossplane/install"
#
#   # Garante que o ArgoCD já existe antes de tentar criar a Application
#   depends_on = [module.argocd]
# }
#
# module "crossplane_configure" {
#   source = "../tf-module-crossplane-app"
#
#   create_secret = false
#
#   argocd_application_name = "crossplane-configuration"
#
#   git_repo_url  = local.git_repo_url_control_plane
#   git_repo_path = "crossplane/configure"
#
#   # Garante que o ArgoCD já existe antes de tentar criar a Application
#   depends_on = [module.crossplane_bootstrap]
# }
#
#
# module "argocd_project_distribution" {
#   source              = "../tf-module-argocd-falo-project"
#   argocd_project_name = local.argocd_project_name
#
#   git_repo_url = local.git_repo_url_distribution
#
#   depends_on = [module.crossplane_bootstrap]
# }
#
# module "argocd_app_distribution" {
#   source = "../tf-module-crossplane-app"
#
#   argocd_project_name            = local.argocd_project_name
#   argocd_application_secret_name = "falo-distribution-secret"
#   argocd_application_name        = "falo-distribuition-application"
#
#   git_repo_url = local.git_repo_url_distribution
#   git_repo_path = "."
#
#   depends_on = [module.argocd_project_distribution]
#
#   directory_recursive = true
#
# }
#
#

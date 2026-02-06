module "checkout" {
  source = "../../tf-module-kind-cluster"
  cluster_name = var.cluster_name
  crossplane_control_plane_cluster = var.crossplane_control_plane_cluster
  is_cluster_data_plane = true
}

module "checkout_argocd_project" {
  source = "../../tf-module-argocd-falo-project"
  cluster_name = var.cluster_name

  providers = {
    kubernetes = kubernetes.control_plane
  }

  git_repo_url = "http://gitea-server:3000/cacetinho-sa-cloudnative/platform-fleet.git" 

  depends_on = [ module.checkout ]
}

module "checkout_argocd_app_infra" {
  source = "../../tf-module-crossplane-app"

  providers = {
    kubernetes = kubernetes.control_plane
  }

  argocd_project_name = local.argocd_project_name
  argocd_application_name = local.argocd_application_name
  argocd_application_secret_name = local.argocd_application_secret_name

  git_repo_url = "http://gitea-server:3000/cacetinho-sa-cloudnative/platform-fleet.git" 
  git_repo_path = "clusters/${var.cluster_name}/infra"

  depends_on = [ module.checkout_argocd_project ]
}

module "control_plane_cluster" {
  source = "../tf-module-kind-cluster"
  cluster_name = "control-plane"
  enable_ingress_ports = true
  is_cluster_gitops_control_plane = true
}

module "argocd" {
  source = "../tf-module-argocd"


  depends_on = [module.control_plane_cluster]
}

module "crossplane_bootstrap" {
  source = "../tf-module-crossplane-app"

  git_repo_url = "http://gitea-server:3000/cacetinho-sa-cloudnative/gitops-platform-config.git" # Ajuste para seu repo

  # Garante que o ArgoCD já existe antes de tentar criar a Application
  depends_on = [module.argocd]
}

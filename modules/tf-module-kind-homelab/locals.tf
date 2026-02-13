locals {
  cluster_name = "control-plane"

  argocd_project_name = "falo-distribution"

  git_repo_url_control_plane = "http://gitea-server:3000/cacetinho-sa-cloudnative/crossplane-control-plane.git"

  git_repo_url_distribution = "http://gitea-server:3000/cacetinho-sa-cloudnative/kubernetes-falo-distribution.git"


}

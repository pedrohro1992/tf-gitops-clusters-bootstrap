locals {
  cluster_name = "control-plane"

  argocd_project_name = "falo-distribution"

  git_repo_url = "http://gitea-server:3000/cacetinho-sa-cloudnative/kubernetes-falo-distribution.git"
}

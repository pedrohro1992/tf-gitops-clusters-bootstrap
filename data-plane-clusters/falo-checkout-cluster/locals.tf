locals {
  argocd_project_name = "${var.cluster_name}-gitops"
  argocd_application_name = "${var.cluster_name}-gitops"
  argocd_application_secret_name = "${var.cluster_name}-gitea-repository"
}

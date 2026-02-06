locals {
  project_name = (var.cluster_name != "" && var.cluster_name != null) ? "${var.cluster_name}-gitops" : var.argocd_project_name
}

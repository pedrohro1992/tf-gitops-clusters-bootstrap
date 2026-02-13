resource "kubernetes_manifest" "argocd_project" {

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "AppProject"
    metadata = {
      name      = local.project_name
      namespace = "argocd" # Ou o namespace onde seu ArgoCD está
    }
    spec = {
      description  = "Projeto GitOps para o cluster ${var.cluster_name}"
      sourceRepos  = [var.git_repo_url]
      
      # Permite que este projeto gerencie qualquer recurso no cluster
      destinations = [{
        server    = "*"
        namespace = "*"
      }]
      
      # Permite todos os tipos de recursos (ClusterRole, Namespace, etc)
      clusterResourceWhitelist = [{
        group = "*"
        kind  = "*"
      }]
    }
  }
}


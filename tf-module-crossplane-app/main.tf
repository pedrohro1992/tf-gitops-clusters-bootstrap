resource "kubernetes_manifest" "crossplane_application" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = var.argocd_application_name
      namespace = "argocd"
    }
    spec = {
      project = var.argocd_project_name
      source = {
        repoURL        = var.git_repo_url
        targetRevision = "HEAD"
        path           = var.git_repo_path
        directory = {
          recurse = var.directory_recursive
        }
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.target_namespace
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }
  depends_on = [ kubernetes_secret_v1.gitea_repo ]
}

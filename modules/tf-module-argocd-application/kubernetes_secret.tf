resource "kubernetes_secret_v1" "gitea_repo" {
  count = var.create_secret ? 1 : 0 

  metadata {
    name      = var.argocd_application_secret_name
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    type          = "git"
    url           = var.git_repo_url
    username      = "argocd"
    password      = "argocd@2026" 
  }

}

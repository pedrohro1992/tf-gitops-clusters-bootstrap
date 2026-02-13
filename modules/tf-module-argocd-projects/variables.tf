variable "cluster_name" {
  type        = string
  description = "Nome do cluster que está sendo criado"
  default = ""
}

variable "argocd_project_name" {
  type = string
  description = "Nome do projeto do Argo que sera criado no ArgoCD"
  default = ""
}

variable "git_repo_url" {
  type        = string
  description = "URL do repositório Git que este projeto tem permissão para usar"
  default     = "*" # Em produção, restrinja ao seu Gitea
}

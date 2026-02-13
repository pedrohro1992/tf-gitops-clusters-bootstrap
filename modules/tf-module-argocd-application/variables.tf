variable "target_namespace" {
  type        = string
  default     = "crossplane-system"
  description = "Namespace onde o Crossplane será instalado pelo ArgoCD"
}

variable "create_secret" {
  type = bool
  description = "Define se o segredo de acesso ao git sera criado"
  default = true
}

variable "directory_recursive" {
  type = bool
  default = false
}

variable "argocd_application_name" {
  type = string
  default = "crossplane-bootstrap"
}

variable "argocd_application_secret_name" {
  type = string
  default = "gitea-repository"
  description = "Define o nome do secret que o ArgoCD ira usar para se conectar ao git"
}

variable "git_repo_url" {
  type        = string
  description = "URL do seu repositório Git local/remoto onde estão os YAMLs do Crossplane"
}

variable "git_repo_path" {
  type        = string
  default     = "crossplane/install"
  description = "Caminho dentro do Git onde está o Helm ou YAMLs do Crossplane"
}

variable "argocd_project_name" {
  type = string
  default = "default"
  description = "Nome do projeto que o cluster ira viver"
}

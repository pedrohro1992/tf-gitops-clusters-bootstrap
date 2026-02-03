variable "cluster_name" {
  type = string
}

variable "enable_ingress_ports" {
  type        = bool
  description = "Habilita o mapeamento das portas 80/443 para o Ingress"
  default     = false
}

variable "is_cluster_gitops_control_plane" {
  description = "Verifica se o cluster tera o ArgoCD e Crossplane instalado nele"
  type = bool
  default = false
}

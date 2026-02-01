variable "cluster_name" {
  type = string
}

variable "enable_ingress_ports" {
  type        = bool
  description = "Habilita o mapeamento das portas 80/443 para o Ingress"
  default     = false
}

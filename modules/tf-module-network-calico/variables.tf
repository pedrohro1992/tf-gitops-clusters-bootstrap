variable "pod_network_cidr" {
  description = "CIDR da rede de Pods do cluster."
  type        = string
  default     = "10.244.0.0/16"
}

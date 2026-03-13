variable "cluster_name" {
  type = string
}

variable "coredns_forward_ip" {
  description = "IP do DNS upstream para a zona customizada"
  type        = string
}

variable "coredns_custom_zone" {
  description = "Zona DNS customizada no formato dominio:porta (ex: homelab.infra.com:53)"
  type        = string
}

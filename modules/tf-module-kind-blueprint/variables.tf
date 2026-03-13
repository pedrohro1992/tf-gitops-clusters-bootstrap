## KUBERNETES VALUES
variable "cluster_name" {
  type = string
}

variable "disable_default_cni" {
  type    = bool
  default = false
}

variable "extra_port_mappings" {
  type = list(object({
    container_port = number
    host_port      = number
    protocol       = string
  }))
  default = []
}

variable "nodes" {
  type = list(object({
    role           = string
    enable_storage = bool
    labels         = map(string)
  }))
  default = [{
    labels         = {}
    enable_storage = false
    role           = ""
  }]
}

variable "kubernetes_host" {
  type = string
  description = "Define o endereco do host do cluster kubernetes"
  default = ""
}

variable "kubernetes_ca_cert" {
  type = string
  description = "Define o certificado para se comunicar com o cluster"
  default = ""
}

variable "token_reviewer_jwt" {
  type = string
  description = "Define token JWT do cluster"
  default = ""
}

# CALICO VALUES
variable "pod_network_cidr" {
  type        = string
  description = "CIDR da rede de Pods do cluster"
}

# OPEN EBS VALUES
variable "create_cluster_storage" {
  type    = bool
  default = false
}

# COREDNS VALUES
variable "coredns_forward_ip" {
  description = "IP do DNS upstream para a zona customizada"
  type        = string
}

variable "coredns_custom_zone" {
  description = "Zona DNS customizada no formato dominio:porta (ex: homelab.infra.com:53)"
  type        = string
}

# EXTERNAL SECRETS OPETATOR VALUES
variable "vault_infra_secret_path" {
  type = string
  description = "Caminho do vault onde os secrets de infra estao configurados"
}

variable "vault_addr" {
  type = string
  description = "URL de acesso ao vault"
}


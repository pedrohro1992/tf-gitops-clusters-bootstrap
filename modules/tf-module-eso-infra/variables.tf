variable "cluster_name" {
  type = string
  description = "Define o nome do cluster"
}

variable "kubernetes_ca_cert" {
  type = string
  description = "Define o certificado para se comunicar com o cluster"
}

variable "vault_infra_secret_path" {
  type = string
  description = "Caminho do vault onde os secrets de infra estao configurados"
}

variable "vault_addr" {
  type = string
  description = "URL de acesso ao vault"
}

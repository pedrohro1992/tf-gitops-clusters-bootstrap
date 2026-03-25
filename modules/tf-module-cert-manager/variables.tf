variable "cluster_name" {
  type        = string
  description = "Name of the Kubernetes Cluster"
}

variable "cert_manager_namespace" {
  description = "Namespace to install cert-manager into"
  type        = string
  default     = "cert-manager"
}

variable "cert_manager_version" {
  description = "cert-manager Helm chart version"
  type        = string
  default     = "v1.14.5"
}

variable "vault_pki_path" {
  description = "Mount path for the Vault PKI secrets engine"
  type        = string
  default     = "pki"
}

variable "vault_pki_int_path" {
  description = "Mount path for the Vault intermediate PKI secrets engine"
  type        = string
  default     = "pki_int"
}

variable "vault_pki_role" {
  description = "Name of the Vault PKI role cert-manager will use to sign certificates"
  type        = string
  default     = "cert-manager-role"
}

variable "vault_auth_path" {
  description = "Mount path for the Vault AppRole auth method"
  type        = string
  default     = "approle"
}

variable "cluster_domain" {
  description = "Base domain for your homelab cluster (used in PKI allowed_domains)"
  type        = string
  default     = "homelab.local"
}


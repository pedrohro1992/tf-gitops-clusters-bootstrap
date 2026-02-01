# variable "host" {
#   type        = string
#   description = "Endpoint do cluster Kubernetes"
# }
#
# variable "client_certificate" {
#   type        = string
#   description = "Certificado do cliente"
# }
#
# variable "client_key" {
#   type        = string
#   description = "Chave privada do cliente"
# }
#
# variable "cluster_ca_certificate" {
#   type        = string
#   description = "CA do cluster"
# }

variable "argocd_version" {
  type        = string
  default     = "7.7.0" # Versão do Helm Chart
  description = "Versão do chart do ArgoCD"
}

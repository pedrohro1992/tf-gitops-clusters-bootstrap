variable "cluster_name" {
  type = string
}

variable "nodes" {
  description = "value"
  type = list(object({
    role = string
    labels = map(string)
  }))
  default = [ {
    role = "control-plane"
    labels = {}
  } ]
}

variable "disable_default_cni" {
  description = "Desabilita CNI default do Kind"
  type = bool
  default = false
}

variable "pod_network_cidr" {
  description = "CIDR da rede de Pods do cluster."
  type        = string
  default     = "10.244.0.0/16"
}


variable "extra_port_mappings" {
  description = "Port mappings do host para o node"
  type = list(object({
    container_port = number
    host_port      = number
    protocol       = string
  }))
  default = []
}

variable "is_cluster_data_plane" {
  description = "Verifica se o cluster e um data-plane"
  type = bool
  default = false
}

variable "crossplane_control_plane_cluster" {
  description = "Nome do cluster onde o control-plane do crossplane esta rodando"
  type = string
  default = ""
}


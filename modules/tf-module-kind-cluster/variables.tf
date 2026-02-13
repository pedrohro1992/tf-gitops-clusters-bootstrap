variable "cluster_name" {
  type = string
}

variable "create_cluster_storage" {
  description = "Define se sera criado o storage para o cluster"
  type        = bool
  default     = false
}
variable "nodes" {
  description = "value"
  type = list(object({
    role           = string
    enable_storage = bool
    labels         = map(string)
  }))
  default = [{
    role           = "control-plane"
    enable_storage = false
    labels         = {}
  }]
}

variable "disable_default_cni" {
  description = "Desabilita CNI default do Kind"
  type        = bool
  default     = false
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


variable "extra_mounts" {
  description = "Extra mounts para os nodes do kind"
  type = list(object({
    host_path      = string
    container_path = string
    read_only      = optional(bool, false)
  }))
  default = []
}

variable "is_cluster_data_plane" {
  description = "Verifica se o cluster e um data-plane"
  type        = bool
  default     = false
}

variable "crossplane_control_plane_cluster" {
  description = "Nome do cluster onde o control-plane do crossplane esta rodando"
  type        = string
  default     = ""
}


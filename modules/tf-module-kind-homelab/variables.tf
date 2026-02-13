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

variable "pod_network_cidr" {
  type        = string
  description = "CIDR da rede de Pods do cluster"
}


variable "create_cluster_storage" {
  type    = bool
  default = false
}

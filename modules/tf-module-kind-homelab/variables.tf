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
    role   = string
    labels = map(string)
  }))
}

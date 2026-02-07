provider "kind" {}

provider "helm" {
  kubernetes = {
    host                   = module.control_plane_cluster.endpoint
    client_certificate     = base64decode(module.control_plane_cluster.client_certificate)
    client_key             = base64decode(module.control_plane_cluster.client_key)
    cluster_ca_certificate = base64decode(module.control_plane_cluster.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = module.control_plane_cluster.endpoint
  client_certificate     = base64decode(module.control_plane_cluster.client_certificate)
  client_key             = base64decode(module.control_plane_cluster.client_key)
  cluster_ca_certificate = base64decode(module.control_plane_cluster.cluster_ca_certificate)
}

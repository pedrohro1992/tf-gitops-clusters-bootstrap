module "control_plane_cluster" {
  source = "../tf-module-kind-cluster"
  cluster_name = "control-plane"
  enable_ingress_ports = true
}

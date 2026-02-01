output "kubeconfig" {
  value     = kind_cluster.this.kubeconfig
  sensitive = true
}

output "endpoint" {
  value = kind_cluster.this.endpoint
}

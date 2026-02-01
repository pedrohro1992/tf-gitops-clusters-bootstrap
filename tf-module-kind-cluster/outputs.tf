output "kubeconfig" {
  value     = kind_cluster.this.kubeconfig
  sensitive = true
}

output "endpoint" {
  value = kind_cluster.this.endpoint
}

output "client_certificate" {
  value = kind_cluster.this.client_certificate
}

output "client_key" {
  value = kind_cluster.this.client_key
}

output "cluster_ca_certificate" {
  value = kind_cluster.this.cluster_ca_certificate
}



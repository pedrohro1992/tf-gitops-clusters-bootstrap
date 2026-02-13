output "endpoint" {
  value = kind_cluster.this.endpoint
}

output "client_certificate" {
  value = base64encode(kind_cluster.this.client_certificate)
}

output "client_key" {
  value = base64encode(kind_cluster.this.client_key)
}

output "cluster_ca_certificate" {
  value = base64encode(kind_cluster.this.cluster_ca_certificate)
}

output "kubeconfig" {
  value = kind_cluster.this.kubeconfig
}



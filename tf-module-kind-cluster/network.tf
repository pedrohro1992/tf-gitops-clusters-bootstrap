resource "null_resource" "connect_gitea_to_kind" {
  count = var.is_cluster_gitops_control_plane ? 1 : 0
  depends_on = [ kind_cluster.this ]

  provisioner "local-exec" {
    command = <<EOF
      # Verifica se o container gitea-server já está na rede kind
      if ! docker inspect gitea-server | grep -q '"kind":'; then
        docker network connect kind gitea-server
        echo "Container gitea-server conectado à rede kind com sucesso."
      else
        echo "gitea-server já está na rede kind."
      fi
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = "docker network disconnect kind gitea-server || true"
  }
}

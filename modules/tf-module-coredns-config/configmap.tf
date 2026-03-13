#TODO: O script que roda para fazer a delecao do configmap ta rodando com o contexto atual, precisa deixar menos "travado"
resource "null_resource" "delete_coredns_configmap" {
  depends_on = [
  ]

  triggers = {
    cluster_name = var.cluster_name
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/delete-coredns.sh"
  }
}

resource "kubernetes_config_map" "coredns" {
  metadata {
    name      = "coredns"
    namespace = "kube-system"
  }

  data = {
    Corefile = templatefile("${path.module}/templates/corefile.tpl", {
      forward_ip  = var.coredns_forward_ip
      custom_zone = var.coredns_custom_zone
    })
  }

  depends_on = [ null_resource.delete_coredns_configmap ]
}

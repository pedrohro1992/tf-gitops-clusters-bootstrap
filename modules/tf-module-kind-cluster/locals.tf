locals {
  storage_path = "/data/kind-storage/${var.cluster_name}"

  ca_pem = data.vault_generic_secret.pki_int_ca_chain.data["certificate"]

  cluster_node_list = toset([
    for n in split(",", data.external.kind_nodes.result["nodes"]) : trimspace(n)
    if trimspace(n) != ""
  ])
  containerd_hosts_toml = <<-TOML
    server = "https://${var.gitea_registry}"

    [host."https://${var.gitea_registry}"]
      capabilities = ["pull", "resolve"]
      ca           = "/etc/ssl/certs/vault-ca-bundle.crt"
  TOML

  ca_tmp_file         = "${path.module}/.tmp/vault-ca-bundle.crt"
  hosts_toml_tmp_file = "${path.module}/.tmp/hosts.toml"
}

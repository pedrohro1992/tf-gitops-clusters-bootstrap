# Escreve a CA PEM para um arquivo temporario 
resource "local_file" "ca_pem" {
  content         = local.ca_pem
  filename        = local.ca_tmp_file
  file_permission = "0600"
}

# Escreve hosts.toml para um arquivo temporario
resource "local_file" "containerd_hosts_toml" {
  content         = local.containerd_hosts_toml
  filename        = local.hosts_toml_tmp_file
  file_permission = "0600"
}

resource "null_resource" "kind_node_ca_trust" {
  for_each = local.cluster_node_list

  triggers = {
    ca_pem              = local.ca_pem
    hosts_toml_tmp_file = local.containerd_hosts_toml
    node                = each.key
  }

  # ── Step 1: inject CA into OS trust store ─────────────────────────────────
  provisioner "local-exec" {
    when    = create
    command = "bash ${path.module}/scripts/write-os-ca.sh ${each.key} ${local.ca_tmp_file}"
  }

  # ── Step 2: write containerd registry hosts config ────────────────────────
  provisioner "local-exec" {
    when    = create
    command = "bash ${path.module}/scripts/write-containerd-hosts.sh ${each.key} ${var.gitea_registry} ${local.hosts_toml_tmp_file}"
  }

  # ── Step 3: restart containerd ────────────────────────────────────────────
  provisioner "local-exec" {
    when    = create
    command = "bash ${path.module}/scripts/restart-containerd.sh ${each.key}"
  }

  depends_on = [
    local_file.ca_pem,
    local_file.containerd_hosts_toml,
    kind_cluster.this
  ]
}

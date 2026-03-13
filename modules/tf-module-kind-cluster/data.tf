data "vault_generic_secret" "pki_int_ca_chain" {
  path = "${var.vault_pki_mount}/cert/ca_chain"
}

data "external" "kind_nodes" {
  program = [
  ]
}

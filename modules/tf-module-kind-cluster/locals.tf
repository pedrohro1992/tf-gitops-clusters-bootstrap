locals {
  storage_path = "/data/kind-storage/${var.cluster_name}"
  ca_pen       = data.vault_generic_secret.pki_int_ca_chain["certificate"]
}

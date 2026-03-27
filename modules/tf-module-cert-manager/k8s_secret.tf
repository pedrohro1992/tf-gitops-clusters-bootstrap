# Create PKI engine
resource "vault_mount" "pki_root" {
  path = var.vault_pki_path
  description = 
}
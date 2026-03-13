resource "kubernetes_cluster_role_binding_v1" "eso_tokenreview" {
  metadata {
    name = "eso-tokenreview-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "system:auth-delegator"
  }

  subject {
    kind = "ServiceAccount"
    name = "eso-sa"
    namespace = kubernetes_namespace_v1.eso.metadata[0].name
  }
}

resource "kubernetes_secret_v1" "eso_token" {
  metadata {
    name = "eso-tokenreview-binding"
    namespace = kubernetes_namespace_v1.eso.metadata[0].name
    annotations = {
      "kubernetes.io/service-account.name" = "eso-sa"
    }
  }

  type = "kubernetes.io/service-account-token"
  depends_on = [ kubernetes_cluster_role_binding_v1.eso_tokenreview ]
}

resource "vault_auth_backend" "kubernetes_eso" {
  type = "kubernetes"

  depends_on = [ kubernetes_cluster_role_binding_v1.eso_tokenreview ]
}

resource "vault_kubernetes_auth_backend_config" "config" {
  backend = vault_auth_backend.kubernetes_eso.path
  kubernetes_host = data.external.kubernetes_api_address.result.host
  kubernetes_ca_cert = var.kubernetes_ca_cert
  token_reviewer_jwt = kubernetes_secret_v1.eso_token.data["token"] 

  disable_local_ca_jwt   = true
}

resource "vault_policy" "eso_policy" {
  name = "eso-policy"

  policy = <<EOT
  path "${var.vault_infra_secret_path}/*" {
  capabilities = ["read"]
  }
  EOT
}

resource "vault_kubernetes_auth_backend_role" "eso_roke" {
  backend = vault_auth_backend.kubernetes_eso.path
  role_name = "eso-role"
  bound_service_account_names = ["eso-sa"]
  bound_service_account_namespaces = [kubernetes_namespace_v1.eso.metadata[0].name]
  token_policies = [vault_policy.eso_policy.name]
  token_ttl = 36000
}


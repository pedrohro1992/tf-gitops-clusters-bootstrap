# resource "kubernetes_manifest" "secretstore" {
#   manifest = {
#     apiVersion = "external-secrets.io/v1"
#     kind       = "SecretStore"
#     metadata = {
#       name      = "vault-backend"
#       namespace = kubernetes_namespace_v1.eso.metadata[0].name
#     }
#     spec = {
#       provider = {
#         vault = {
#           server = var.vault_addr
#           path   = "secret"
#           version = "v2"
#           auth = {
#             kubernetes = {
#               mountPath = "auth/kubernetes"
#               role      = "eso-role"
#               serviceAccountRef = {
#                 name = "eso-sa"
#               }
#             }
#           }
#         }
#       }
#     }
#   }
#
#   depends_on = [ kubernetes_secret_v1.eso_token ]
# }

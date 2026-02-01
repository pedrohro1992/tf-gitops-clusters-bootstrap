# terraform {
#   required_version = "v1.14.4"
#   required_providers {
#     kind = {
#       source  = "tehcyx/kind"
#       version = "0.10.0" # Verifique a versão mais atual disponível
#     }
#   }
# }

terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.10.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1.1"
    }
  }
}

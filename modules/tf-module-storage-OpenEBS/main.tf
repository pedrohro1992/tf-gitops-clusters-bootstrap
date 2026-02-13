resource "helm_release" "openebs" {
  name             = "openebs"
  repository       = "https://openebs.github.io/openebs"
  chart            = "openebs"
  version          = "4.1.3"
  create_namespace = true

  values = [
    yamlencode({

      # Desabilita Mayastor
      engines = {
        replicated = {
          mayastor = {
            enabled = false
          }
        }
      }

      localprovisioner = {
        basePath = "/var/openebs"

        nodeSelector = {
          "storage.openebs.io/enabled" = "true"
        }

        resources = {
          requests = {
            cpu    = "50m"
            memory = "64Mi"
          }
          limits = {
            cpu    = "200m"
            memory = "128Mi"
          }
        }
      }

      admissionServer = {
        resources = {
          requests = {
            cpu    = "25m"
            memory = "32Mi"
          }
          limits = {
            cpu    = "100m"
            memory = "64Mi"
          }
        }
      }

    })
  ]

}

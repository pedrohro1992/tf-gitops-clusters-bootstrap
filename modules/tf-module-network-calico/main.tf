resource "helm_release" "calico_operator" {
  name             = "calico"
  namespace        = "tigera-operator"
  create_namespace = true

  repository = "https://docs.tigera.io/calico/charts"
  chart      = "tigera-operator"
  version    = "v3.31.3"

  timeout           = 600
  atomic            = true
  cleanup_on_fail   = true
  dependency_update = true

  values = [
    yamlencode({
      installation = {
        kubernetesProvider = "Kind"

        calicoNetwork = {
          bgp = "Disabled"

          ipPools = [
            {
              cidr          = var.pod_network_cidr
              encapsulation = "VXLAN"
              natOutgoing   = "Enabled"
              nodeSelector  = "all()"
            }
          ]
        }

        componentResources = [
          {
            componentName = "Node"
            resourceRequirements = {
              requests = {
                cpu    = "100m"
                memory = "128Mi"
              }
              limits = {
                cpu    = "300m"
                memory = "256Mi"
              }
            }
          },
          {
            componentName = "KubeControllers"
            resourceRequirements = {
              requests = {
                cpu    = "50m"
                memory = "64Mi"
              }
              limits = {
                cpu    = "200m"
                memory = "128Mi"
              }
            }
          },
          {
            componentName = "Typha"
            resourceRequirements = {
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
        ]
      }

      tigeraOperator = {
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
    })
  ]
}

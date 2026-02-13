resource "helm_release" "calico_operator" {
  name       = "calico"
  namespace  = "tigera-operator"
  create_namespace = true

  repository = "https://docs.tigera.io/calico/charts"
  chart      = "tigera-operator"
  version    = "v3.31.3"

  # Aguarda recursos ficarem prontos
  timeout          = 600
  atomic           = true
  cleanup_on_fail  = true
  dependency_update = true

  values = [
    yamlencode({
      installation = {
        kubernetesProvider = "kubernetes"

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
      }
    })
  ]
}

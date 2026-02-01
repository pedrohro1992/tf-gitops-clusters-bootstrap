resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = var.argocd_version

  # Forçamos o ArgoCD a usar os NodePorts mapeados no Kind
  set = [
    {
      name  = "server.service.type"
      value = "NodePort"
    },
    {
      name  = "server.service.nodePort.http"
      value = "30080"
    },
    {
      name  = "server.service.nodePort.https"
      value = "30443"
    },

    {
      name  = "server.extraArgs"
      value = "{--insecure}"
    },
  ] 
}

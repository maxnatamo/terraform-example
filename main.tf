data "terraform_remote_state" "gitlab" {
  backend = "http"

  config = {
    address  = var.remote_state_address
    username = var.remote_state_username
    password = var.remote_state_access_token
  }
}

# Create MetalLB namespace
resource "kubernetes_namespace" "metallb" {
  metadata {
    name = "metallb"
  }
}

# Install MetalLB with Helm
resource "helm_release" "metallb_helm" {
  name      = "metallb"
  namespace = "metallb"
  chart     = "metallb"

  wait          = true
  wait_for_jobs = true

  repository = "https://metallb.github.io/metallb"

  depends_on = [
    kubernetes_namespace.metallb
  ]
}

# Instantiate IPAddressPool-resource for MetalLB
resource "kubectl_manifest" "metallb_addr_pool" {
  yaml_body = <<YAML
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: ${var.metallb_addr_pool_name}
  namespace: metallb
spec:
  addresses:
    - ${var.metallb_addr_pool_range}
YAML

  depends_on = [
    helm_release.metallb_helm
  ]
}

# Instantiate L2Advertisement-resource for MetalLB
resource "kubectl_manifest" "metallb_l2_adv" {
  yaml_body = <<YAML
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: ${var.metallb_addr_pool_name}
  namespace: metallb
spec:
  ipAddressPools:
    - ${var.metallb_addr_pool_name}

YAML

  depends_on = [
    helm_release.metallb_helm
  ]
}

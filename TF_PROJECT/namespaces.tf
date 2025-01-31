resource "kubernetes_namespace" "namespace" {
    for_each = toset(var.environments)
    metadata {
      name = each.key
      labels = {
        client = var.client_name
      }
    }
} 
resource "kubernetes_namespace" "client_ns" {
  for_each = {
    for client, config in var.clients : client => {
      for env in var.environment : "${client}-${env}" => {
        client     = client
        namespace  = "${client}-${env}"
        env        = env
      }
    }
  }

  metadata {
    name = each.value.namespace
  }
}

resource "kubernetes_deployment" "client_deployment" {
  for_each = {
    for client, config in var.clients : client => {
      for env in var.environment : "${client}-${env}" => {
        client     = client
        namespace  = "${client}-${env}"
        replicas   = config.replicas[env]
        image      = config.image
        env        = env
      }
    }
  }

  metadata {
    name      = "odoo-${each.value.env}"
    namespace = each.value.namespace
    labels = {
      app         = "odoo"
      environment = each.value.env
    }
  }

  spec {
    replicas = each.value.replicas

    selector {
      match_labels = {
        app = "odoo"
      }
    }

    template {
      metadata {
        labels = {
          app = "odoo"
        }
      }

      spec {
        container {
          name  = "odoo"
          image = each.value.image

          port {
            container_port = 8069
          }

          env {
            name  = "POSTGRES_HOST"
            value = "postgres-service"
          }

          env {
            name  = "POSTGRES_USER"
            value = "odoo"
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = "odoo"
          }
        }
      }
    }
  }
}

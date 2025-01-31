resource "kubernetes_secret" "odoo-secrets" {
  for_each = toset(var.environments)
  metadata {
    name      = "odoo-secrets"
    namespace = each.key
  }

  data = {
    postgres_password = var.postgres_password
  }
}


# ODOO DEPLOYMENT
resource "kubernetes_deployment" "odoo-app" {
  for_each = toset(var.environments)
  metadata {
    name = "${var.app_name}-${each.key}" #X var.app_name
    namespace = each.key
  }

  spec {
    replicas = var.app_replica_amount #X

    selector {
      match_labels = {
        app = var.app_name #X
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name #X
        }
      }

      spec {
        container {
          name  = "${var.app_name}-container-${terraform.workspace}" #X
          image = var.app_image #X
          port {
            container_port = var.app_container_port #X
          }

          env {
            name  = "POSTGRES_HOST"
            value = var.postgres_host #X
          }

          env {
            name  = "POSTGRES_DB"
            value = var.postgres_db #X
          }

          env {
            name  = "POSTGRES_USER"
            value = var.postgres_user #X
          }

          env {
            name = "POSTGRES_PASSWORD"
              value_from {
                secret_key_ref {
                  name = kubernetes_secret.odoo-secrets[each.key].metadata[0].name # try: kubernetes_secret.odoo-secrets[each.key].metadata[0].name // kubernetes_secret.odoo-secrets.metadata[0].name
                  key  = "postgres_password" # Ensure this key exists in your secret
                }
              }
            }
        }
      }
    }
  }
}


# POSTGRES DEPLOYMENT
resource "kubernetes_deployment" "postgres-db" {
  for_each = toset(var.environments)
  metadata {
    name = "${var.app_db_name}-${each.key}" #X
    namespace = each.key
  }

  spec {
    replicas = var.db_replica_amount #X

    selector {
      match_labels = {
        app = var.app_db_name #X
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_db_name #X
        }
      }

      spec {
        container {
          name  = "${var.app_db_name}-container-${terraform.workspace}" #X
          image = var.app_db_image #X
          port {
            container_port = var.app_db_container_port #X
          }

          env {
            name  = "POSTGRES_DB"
            value = var.postgres_db #X
          }

          env {
            name  = "POSTGRES_USER"
            value = var.postgres_user #X
          }

          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.odoo-secrets[each.key].metadata[0].name # kubernetes_secret.odoo-secrets.metadata[0].name
                key  = "postgres_password" # Ensure this key exists in your secret
              }
            }
          }
        }
      }
    }
  }
}



# ODOO SERVICE
resource "kubernetes_service" "odoo-service" {
  for_each = toset(var.environments)
  metadata {
    name = "odoo-service-${each.key}"
    namespace = each.key
  }

  spec {
    selector = {
      app = var.app_name #X
    }

    port {
      protocol    = "TCP"
      port        = var.app_container_port #X
      target_port = var.app_container_port #X
    }

    type = "ClusterIP"
    
  }
}


# POSTGRES SERVICE
resource "kubernetes_service" "postgres-service" {
  for_each = toset(var.environments)
  metadata {
    name = "postgres-service-${each.key}"
    namespace = each.key
  }

  spec {

    selector = {
      app = var.app_db_name #X
    }

    port {
      protocol    = "TCP"
      port        = var.app_db_container_port #X
      target_port = var.app_db_container_port #X
    }

    type = "ClusterIP"

  }
}



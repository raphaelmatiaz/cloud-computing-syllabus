# terraform {
#   required_providers {
#     minikube = {
#       source = "scott-the-programmer/minikube"
#       version = "0.4.4"
#     }
#     kubernetes = {
#       source = "hashicorp/kubernetes"
#       version = "2.21.1"
#     }
#   }
# }

# provider "minikube" {
#   # Configuration options
# }

# provider "kubernetes" {
#   # Configuration options
#   host = minikube_cluster.tf-project-cluster.host
#   cluster_ca_certificate = minikube_cluster.tf-project-cluster.cluster_ca_certificate
#   client_certificate = minikube_cluster.tf-project-cluster.client_certificate
#   client_key = minikube_cluster.tf-project-cluster.client_key
# }


# resource "minikube_cluster" "tf-project-cluster" {
#     cluster_name = "${terraform.workspace}-Cluster"
#     driver = "docker"
#     addons = [
#     "ingress",
#   ]
# }

# resource "kubernetes_secret" "tls_secret" {
#   metadata {
#     name      = "tls-secret"
#     namespace = "prod"  # Match your ingress namespace
#   }

#   data = {
#     "tls.crt" = filebase64("${path.module}/domain.crt")  # Encode the certificate file in base64
#     "tls.key" = filebase64("${path.module}/domain.key")  # Encode the private key file in base64
#   }

#   type = "kubernetes.io/tls"  # Specify the TLS secret type
# }

# resource "kubernetes_secret" "odoo-secrets" {
#   for_each = toset(var.environments)
#   metadata {
#     name      = "odoo-secrets"
#     namespace = each.key
#   }

#   data = {
#     postgres_password = var.postgres_password
#   }
# }


# # ODOO DEPLOYMENT
# resource "kubernetes_deployment" "odoo-app" {
#   for_each = toset(var.environments)
#   metadata {
#     name = "${var.app_name}-${each.key}" #X var.app_name
#     namespace = each.key
#   }

#   spec {
#     replicas = var.app_replica_amount #X

#     selector {
#       match_labels = {
#         app = var.app_name #X
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = var.app_name #X
#         }
#       }

#       spec {
#         container {
#           name  = "${var.app_name}-container-${terraform.workspace}" #X
#           image = var.app_image #X
#           port {
#             container_port = var.app_container_port #X
#           }

#           env {
#             name  = "POSTGRES_HOST"
#             value = var.postgres_host #X
#           }

#           env {
#             name  = "POSTGRES_DB"
#             value = var.postgres_db #X
#           }

#           env {
#             name  = "POSTGRES_USER"
#             value = var.postgres_user #X
#           }

#           env {
#             name = "POSTGRES_PASSWORD"
#               value_from {
#                 secret_key_ref {
#                   name = kubernetes_secret.odoo-secrets.metadata[0].name
#                   key  = "postgres_password" # Ensure this key exists in your secret
#                 }
#               }
#             }
#         }
#       }
#     }
#   }
# }


# # POSTGRES DEPLOYMENT
# resource "kubernetes_deployment" "postgres-db" {
#   for_each = toset(var.environments)
#   metadata {
#     name = "${var.app_db_name}-${each.key}" #X
#     namespace = each.key
#   }

#   spec {
#     replicas = var.db_replica_amount #X

#     selector {
#       match_labels = {
#         app = var.app_db_name #X
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = var.app_db_name #X
#         }
#       }

#       spec {
#         container {
#           name  = "${var.app_db_name}-container-${terraform.workspace}" #X
#           image = var.app_db_image #X
#           port {
#             container_port = var.app_db_container_port #X
#           }

#           env {
#             name  = "POSTGRES_DB"
#             value = var.postgres_db #X
#           }

#           env {
#             name  = "POSTGRES_USER"
#             value = var.postgres_user #X
#           }

#           env {
#             name = "POSTGRES_PASSWORD"
#             value_from {
#               secret_key_ref {
#                 name = kubernetes_secret.odoo-secrets.metadata[0].name
#                 key  = "postgres_password" # Ensure this key exists in your secret
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }



# # ODOO SERVICE
# resource "kubernetes_service" "odoo-service" {
#   for_each = toset(var.environments)
#   metadata {
#     name = "odoo-service-${each.key}"
#     namespace = each.key
#   }

#   spec {
#     selector = {
#       app = var.app_name #X
#     }

#     port {
#       protocol    = "TCP"
#       port        = var.app_container_port #X
#       target_port = var.app_container_port #X
#     }

#     type = "ClusterIP"
    
#   }
# }


# # POSTGRES SERVICE
# resource "kubernetes_service" "postgres-service" {
#   for_each = toset(var.environments)
#   metadata {
#     name = "postgres-service-${each.key}"
#     namespace = each.key
#   }

#   spec {

#     selector = {
#       app = var.app_db_name #X
#     }

#     port {
#       protocol    = "TCP"
#       port        = var.app_db_container_port #X
#       target_port = var.app_db_container_port #X
#     }

#     type = "ClusterIP"

#   }
# }

# resource "kubernetes_namespace" "namespace" {
#     for_each = toset(var.environments)
#     metadata {
#       name = each.key
#       labels = {
#         client = var.client_name
#       }
#     }
# } 


# resource "kubernetes_ingress_v1" "odoo_ingress" {
#   for_each = toset(var.environments)

#   metadata {
#     name      = "odoo-ingress"
#     namespace = each.key  # Dynamic namespace based on environment
#     annotations = {
#       "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
#     }
#   }

#   spec {
#     rule {
#       host = "${terraform.workspace}-odoo.com"

#       http {
#         path {
#           path = "/"
#           path_type = "Prefix"

#           backend {
#             service {
#               name = "odoo-service"
#               port {
#                 number = var.app_container_port
#               }
#             }
#           }
#         }
#       }
#     }

#     # Define TLS section
#     tls {
#       hosts = ["${terraform.workspace}-odoo.com"]
#       secret_name = kubernetes_secret.tls_secret.metadata[0].name  # Reference the TLS secret
#     }
#   }
# }


# variable "environments" {
#     type = list(string)
#     default = ["dev", "beta", "prod"]
#     description = "Environment (aka k8s namespace)"
# }

# variable "app_name" {
#     type = string
#     default = "my-app"
#     description = "Name attributed to the app"
# }

# variable "client_name" {
#     type = string
#     description = "The name of the Client"
# }

# variable "app_replica_amount" {
#     type = number
#     description = "The amount of replicas of the app"
# }

# variable "db_replica_amount" {
#     type = number
#     default = 1
#     description = "The amount of replicas of the app"
# }


# # Postgres DB Stuff
# variable "postgres_host" {
#   type        = string
#   default = "host"
#   description = "The PostgreSQL Host"
# }

# variable "postgres_db" {
#   type        = string
#   default = "db"
#   description = "The name of the PostgreSQL database"
# }

# variable "postgres_user" {
#   type        = string
#   default = "user"
#   description = "The PostgreSQL user"
# }

# variable "postgres_password" {
#   type        = string
#   default = "password"
#   description = "The password for the PostgreSQL user"
# }

# variable "app_db_name" {
#     type = string
#     default = "db"
#     description = "The database name of the app"
# }

# variable "app_db_image" {
#     type = string
#     default = "postgres:13"
#     description = "The db image for the db container of the app"
# }

# variable "app_db_container_port" {
#     type = number
#     default = 5432
#     description = "The db container's exposed port number"
# }

# variable "app_db_container_name" {
#     type = string
#     default = "db-container"
#     description = "The db container's name"
# }


# variable "app_image" {
#   type        = string
#   default     = "odoo:18"
#   description = "The Docker image for Odoo"
# }

# variable "app_container_name" {
#     type = string
#     default = "app-container"
#     description = "The app container's name"
# }

# variable "app_container_port" {
#     type = number
#     default = 8069
#     description = "The exposed port on the odoo container"
# }



# variable "app_host_port" {
#     type = number
#     default = 8069
#     description = "The exposed host port to be mapped to the odoo app's container port"
# }





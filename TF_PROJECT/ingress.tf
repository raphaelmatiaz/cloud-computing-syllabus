# resource "kubernetes_ingress_v1" "odoo_ingress" {
#   for_each = toset(var.environments)
#   metadata {
#     name      = "odoo-ingress"
#     namespace = each.key
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
#   }
# }

# resource "kubernetes_ingress_v1" "odoo_ingress" {
#   for_each = toset(var.environments)

#   metadata {
#     name      = "odoo-ingress"
#     namespace = each.key  
#     # annotations = {
#     #   "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
#     # }
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






# LAST HEALTHY INGRESS
resource "kubernetes_ingress_v1" "odoo_ingress" {
  for_each = toset(var.environments)

  metadata {
    name      = "odoo-ingress"
    namespace = each.key  # Dynamic namespace for each environment
    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect" = "true"  # Optional, for SSL redirection if you want
    }
  }

  spec {
    rule {
      host = "${terraform.workspace}.odoo.com"  # Adjust the hostname as needed

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "odoo-service"  # Assuming your service is named odoo-service
              port {
                number = var.app_container_port  # Reference to the port variable
              }
            }
          }
        }
      }
    }

    tls {
      hosts       = ["${terraform.workspace}-odoo.com"]
      secret_name = kubernetes_secret.tls_secret.metadata[0].name  # Reference to your TLS secret
    }
  }
}



# resource "kubernetes_ingress_v1" "odoo_ingress" { 
#   for_each = toset(var.environments)

#   metadata {
#     name      = "odoo-ingress"
#     namespace = each.key  # Dynamic namespace for each environment
#     annotations = {
#       "nginx.ingress.kubernetes.io/ssl-redirect" = "true"  # Enables SSL redirection
#     }
#   }

#   spec {
#     rule {
#       host = "${terraform.workspace}.odoo.com"  # Adjust the hostname as needed

#       http {
#         path {
#           path      = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = "odoo-service"  # Service name remains unchanged
#               port {
#                 number = var.app_container_port  # Reference to app container port
#               }
#             }
#           }
#         }
#       }
#     }

#     tls {
#       hosts       = ["${terraform.workspace}.odoo.com"]
#       secret_name = kubernetes_secret.tls_secret.metadata[0].name  # Correct TLS secret reference
#     }
#   }
# }
























# resource "kubernetes_service_v1" "odoo_service" {
#   metadata {
#     name = "odoo-service"
#   }

#   spec {
#     selector = {
#       app = kubernetes_pod.odoo_pod.metadata[0].labels.app
#     }
#     session_affinity = "ClientIP"
#     port {
#       port        = var.app_container_port  # Dynamic port for your application
#       target_port = 80
#     }
#     type = "ClusterIP"  # Choose the appropriate service type (ClusterIP for internal use or NodePort for external)
#   }
# }

# resource "kubernetes_pod" "odoo_pod" {
#   metadata {
#     name = "odoo-pod"
#     labels = {
#       app = "odoo"
#     }
#   }

#   spec {
#     container {
#       image = "nginx:1.7.9"  # Example container image, replace with your app image
#       name  = "odoo-container"
#       port {
#         container_port = var.app_container_port  # Dynamic container port
#       }
#     }
#   }
# }



# #MCCARTNEY
# resource "kubernetes_ingress_v1" "odoo_ingress" {
#   metadata {
#     name      = "odoo-ingress"
#     namespace = var.namespace
#     annotations = {
#       "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
#     }
#   }

#   spec {
#     rule {
#       host = var.domain

#       http {
#         path {
#           path = "/"
#           path_type = "Prefix"

#           backend {
#             service {
#               name = "odoo-service"
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }


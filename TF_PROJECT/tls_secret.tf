resource "kubernetes_secret" "tls_secret" {
  metadata {
    name      = "tls-secret"
    namespace = "prod"  # Match your ingress namespace
  }

  data = {
    "tls.crt" = filebase64("${path.module}/domain.crt")  # Encode the certificate file in base64
    "tls.key" = filebase64("${path.module}/domain.key")  # Encode the private key file in base64
  }

  type = "kubernetes.io/tls"  # Specify the TLS secret type
}
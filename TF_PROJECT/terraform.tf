terraform {
  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.4.4"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.21.1"
    }
  }
}

provider "minikube" {
  # Configuration options
}

provider "kubernetes" {
  # Configuration options
  host = minikube_cluster.tf-project-cluster.host
  cluster_ca_certificate = minikube_cluster.tf-project-cluster.cluster_ca_certificate
  client_certificate = minikube_cluster.tf-project-cluster.client_certificate
  client_key = minikube_cluster.tf-project-cluster.client_key
}

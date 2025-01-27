resource "minikube_cluster" "tf-project-cluster" {
    cluster_name = "terraform-project"
    driver = "docker"
    addons = [
    "ingress",
  ]
}
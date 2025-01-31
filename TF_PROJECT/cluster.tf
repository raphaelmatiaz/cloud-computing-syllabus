resource "minikube_cluster" "tf-project-cluster" {
    cluster_name = "${terraform.workspace}-Cluster"
    driver = "docker"
    addons = [
    "ingress",
  ]
}


# ${terraform.workspace} é para referir-se ao nome do workspace atual
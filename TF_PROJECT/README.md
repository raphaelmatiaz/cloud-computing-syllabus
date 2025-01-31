1. make workspaces: creates workspaces Netfilx, Meta and Rockstar
2. terraform workspace list: lists the created workspaces. Makes sure they are there.
3. fiz terraform init no workspace 'Rockstar' e isto funcionou. Criou um cluster





algures aqui fazer um plan dentro do workspace que estamos, e aplicar o documento de variaveis correspondente com a flag -var-file.

Exemplo: 

workspace Netflix: terraform plan -var-file=client_netflix.tf + terraform apply plan        workspace Rockstar terraform plan -var-file=client_rockstar.tf + terraform apply plan
workspace Meta: terraform plan -var-file=client_meta + terraform apply plan


REQUIREMENTS:

1. ter docker ou docker desktop instalado e a correr
2. 


# Terraform Project: Multi-Client Kubernetes Cluster with Odoo Deployment

## Project Overview

This project aims to provision a flexible and scalable infrastructure using Terraform to support deployments for three distinct clients: Netflix, Meta, and Rockstar. Each client will have its own isolated environment managed through Terraform workspaces. The infrastructure includes a Kubernetes cluster where the Odoo application will be deployed with secure HTTPS access configured across environments.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Terraform**: [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- **Minikube**: [Install Minikube](https://minikube.sigs.k8s.io/docs/start/)
- **Kubectl**: [Install Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- **Make**: [Install Make](https://www.gnu.org/software/make/)

Additionally, ensure you have the following configured:

- **Access to Docker**: Ensure Docker is installed and running, as Minikube requires Docker to manage the Kubernetes cluster.

## Project Structure

The project is organized as follows:

```
.
├── terraform.tf           # Primary Terraform configuration
├── vars.tf                # Input variables for the project
├── odoo_postgres.tf       # odoo and postgres deployments, services and secret
├── tls_secret.tf          # TLS secret
├── namespaces.tf          # namespaces resources
├── ingress.tf             # ingress resources
├── cluster.tf             # cluster resources
├── client_netflix.tfvars  # Variables specific to Netflix
├── client_meta.tfvars     # Variables specific to Meta
├── client_rockstar.tfvars # Variables specific to Rockstar 
├── domain.crt and domain.key # SSL/TLS encryption
├── Makefile               # Makefile for automation
└── README.md              # Project documentation
```

## Setup and Deployment

Follow these steps to set up and deploy the infrastructure for each client:

### 1. Initialize Terraform

Open a terminal and navigate to the project directory. Run the following command to initialize the Terraform configuration:

```bash
terraform init
```

### 2. Create Terraform Workspaces

Run the following command to create workspaces for each client:

```bash
make workspaces
```

This command will execute the `workspaces` target in the Makefile, creating new workspaces for Netflix, Meta, and Rockstar.

### 3. Deploy Infrastructure for a Client

To deploy the infrastructure for a specific client, run the corresponding Makefile target. For example, to deploy for Netflix:

```bash
make netflix
```

This command will:
- Select the `netflix` workspace.
- Plan the Terraform deployment using `client_netflix.tfvars`.
- Apply the planned configuration to provision the resources.

Repeat this step for the other clients by replacing `netflix` with `meta` or `rockstar` in the command above.

## Makefile Targets

The Makefile includes the following targets:

### Workspaces

Creates Terraform workspaces for each client.

```makefile
workspaces:
	terraform workspace new netflix
	terraform workspace new meta
	terraform workspace new rockstar
```

### Deploy Netflix Infrastructure

```makefile
netflix:
	terraform workspace select netflix
	terraform plan -var-file=client_netflix.tfvars -out=plan
	terraform apply plan
```

### Deploy Meta Infrastructure

```makefile
meta:
	terraform workspace select meta
	terraform plan -var-file=client_meta.tfvars -out=plan
	terraform apply plan
```

### Deploy Rockstar Infrastructure

```makefile
rockstar:
	terraform workspace select rockstar
	terraform plan -var-file=client_rockstar.tfvars -out=plan
	terraform apply plan
```

## Notes

- Ensure that the `client_netflix.tfvars`, `client_meta.tfvars`, and `client_rockstar.tfvars` files contain the appropriate variable definitions for each client. You may modify them as desired in order to create specific infrastructure configurations for each client.

- You may add a new client to the configuration by adding an edited replica of the makefile command sequence of any other client, as well as adding a new '<new_client>.tfvars' file to the project directory, with variables dedicated to that new client.

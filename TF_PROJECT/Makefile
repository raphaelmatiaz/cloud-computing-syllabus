workspaces:
	- terraform workspace new netflix 
	- terraform workspace new meta
	- terraform workspace new rockstar


netflix:
	- terraform workspace select netflix
	- terraform plan -var-file=client_netflix.tfvars -out=plan
	- terraform apply plan


meta:
	- terraform workspace select meta
	- terraform plan -var-file=client_meta.tfvars -out=plan
	- terraform apply plan


rockstar:
	- terraform workspace select rockstar
	- terraform plan -var-file=client_rockstar.tfvars -out=plan
	- terraform apply plan


# kubectl config current-context: SHOW CURRENT CONTEXT

# terraform workspace list: LIST WORKSPACES

# terraform workspace show: SHOW CURRENT WORKSPACE

# minikube start -p <cluster-name>: START A STOPPED CLUSTER

# kubectl config get-clusters: LIST CLUSTERS

# kubectl cluster-info : IS KUBERNETES RUNNING?

# kubectl get pods -A : vai buscar os pods todos



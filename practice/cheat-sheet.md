__________________________________________________________________________________________________________________

**KUBERNETES 80/20 Commands (GPT):**
_________________________________________________________________________________________________________________

**Minikube Commands**

**minikube start:** "Initializes a local Kubernetes cluster."
**minikube stop:** "Halts the Minikube virtual machine."
**minikube delete:** "Removes the Minikube cluster and its resources."
**minikube status:** "Displays the current status of the Minikube cluster."
**minikube dashboard:** "Opens the Kubernetes dashboard in a browser."
**minikube ip:** "Shows the IP address of the Minikube cluster."
**minikube addons enable ADDON_NAME:** "Activates a specific Kubernetes add-on like metrics-server or ingress."


__________________________________________________________________________________________________________________

**Kubectl Commands**

**kubectl run POD_NAME --image=IMAGE_NAME:** "Creates a pod with the specified name and image."
**kubectl create -f FILE_NAME.yaml:** "Creates a pod (or other resources) using the settings defined in a YAML file."
**kubectl run POD_NAME --image=IMAGE_NAME --dry-run=client -o yaml > pod-template.yaml:** "Generates a YAML template for creating a pod, allowing for further modifications."

**kubectl cluster-info:** "Provides details about the cluster's control plane and services."
**kubectl get all:** "Lists all pods, services, deployments, and other resources in the namespace."
**kubectl get pods/services:** "Displays information about pods or services in the cluster."
**kubectl describe POD_NAME:** "Shows detailed information about a specific pod, including events."
**kubectl apply -f FILE_NAME.yaml:** "Creates or updates resources defined in a YAML file."
**kubectl delete pod POD_NAME:** "Removes a specific pod by name."
**kubectl delete -f FILE_NAME.yaml:** "Deletes resources defined in a YAML file."
**kubectl logs POD_NAME:** "Retrieves logs from a running or completed pod."
**kubectl exec -it POD_NAME -- /bin/bash:** "Opens a shell inside a container for debugging."
**kubectl config set-context --current --namespace=NAMESPACE:** "Changes the default namespace for kubectl commands."
**kubectl port-forward POD_NAME LOCAL_PORT:TARGET_PORT:** "Accesses a pod's service from your local machine."
**kubectl scale deployment DEPLOYMENT_NAME --replicas=NUM:** "Adjusts the number of pod replicas for a deployment."
**kubectl top pods/nodes:** "Displays CPU and memory usage for pods or nodes (requires metrics-server)."

**kubectl apply -f <deployment-name.yaml**: Create a deployment from a .yaml file.


__________________________________________________________________________________________________________________

FLAGS

**kubectl Flags:**

--dry-run: In Kubernetes, --dry-run is a flag used with kubectl commands to simulate the execution of the 
command without actually applying any changes to the cluster. It helps test and validate the 
configuration or command before making real changes.


__________________________________________________________________________________________________________________
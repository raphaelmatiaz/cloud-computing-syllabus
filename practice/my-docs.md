**VOCABULARY**


*General*

**Production Environment:**

A production environment is where your application is live and available for real users 
to interact with, as opposed to being in development or testing stages.

________________________________________________________________________________________

**Downtime:**

Downtime is when your production application (running in containers) is unavailable or 
not working as expected, preventing users from accessing or using it.

________________________________________________________________________________________

**Workloads:**

In Kubernetes, a workload is an application or task running on the cluster, managed by 
Kubernetes resources like Pods, Deployments, or Jobs.

________________________________________________________________________________________

**Load Balancing:**

In Kubernetes, load balancing is the process of evenly distributing incoming traffic 
across multiple application instances (Pods) to ensure reliability and optimal performance.

________________________________________________________________________________________

**Nginx**

Nginx (pronounced "engine-x") is a powerful, open-source web server and reverse proxy. 
It is commonly used to:

1. Serve Web Pages: It can deliver static files (like HTML, CSS, and images) or act as 
a front-end to backend applications.

2. Load Balancing: Distributes traffic across multiple servers to handle more users and 
ensure reliability.

3. Reverse Proxy: Acts as a gateway between users and backend servers, often used to 
hide the server's details, improve security, or cache responses for speed.

4. Security and Performance: It can handle high traffic with low memory usage and 
includes features like SSL termination and request filtering.

____________________________________________________________________________________________


*Kubernetes Components*

**Cluster:**
In Kubernetes, a cluster is a group of computers (nodes) that know about each other and 
work together to run and manage your applications.

It's basically a wrapper around the control plane and the nodes.

_________________________________________________________________________________________

**Control Plane (part A of the cluster):**

In Kubernetes, the control plane is the part of the system that manages the cluster, 
deciding what runs where and ensuring the desired state of applications is maintained.

A cluster must contain at least one control plane. 

A cluster can exist with only one control plane, which can also act as a worker node. 
This is uncommon to see, however, in production, where at least one node will coexist 
with the control plane, to handle the workload

A cluster can have more than one control plane.

Also known as 'Master Node' or 'Master'.

________________________________________________________________________________________

**Nodes (part B of the cluster):**

In Kubernetes, a node is a single machine (virtual or physical) that runs application 
containers. 

A set of working nodes refers to multiple nodes in a cluster that handle the actual 
workload, managed by the control plane.

Nodes in a cluster have their own IP addresses and exist within a virtual network, allowing 
for communication between them.

Usually, nodes contain multiple pods.

Also known as 'Worker', 'Worker Machine' or 'Worker Node'.



________________________________________________________________________________________


*Sub-Components of Control Plane (Part A of the Cluster)*


**cloud-controller-manager**

This component manages the interaction between Kubernetes and the underlying cloud 
infrastructure, such as managing load balancers and storage.

**kube-api-server**

The API server is the central component of Kubernetes that processes requests from 
users and other components, serving as the interface to interact with the cluster.

It's the entry point to the cluster, to which we can talk via a UI, a CLI or scripts.

**etcd**

A distributed key-value storage that Kubernetes uses to store all its cluster data, 
such as configurations and current state of the cluster.

Data is commonly stored in JSON or Protobuf formats here.

**scheduler (kube-scheduler)**

The Kubernetes scheduler is responsible for assigning Pods to nodes based on resource 
availability and constraints.

**Controller Manager (kube-controller-manager)**

This component manages controllers that handle routine tasks in the cluster, such as 
scaling Pods, ensuring the desired state, and managing replication.


________________________________________________________________________________________


*Sub-Components of Nodes (Part B of the Cluster)*



**Pod**

A Pod is the smallest and simplest unit in Kubernetes. It's a wrapper around a group of one or 
more containers that are deployed together on the same node.

It represents the execution environment for containers that are part of an app's service.

A Pod can contain multiple containers (usually one), which share the same network IP, storage, 
and can communicate with each other easily.

Containers within the same Pod are tightly coupled and are usually run together because they 
need to share resources or are part of the same application.

Each Pod is assigned a unique IP address within the cluster, allowing the containers inside 
the Pod to communicate using that IP.

Pods contain generally a single container.

-   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

**Kublet**

An agent running on each node that ensures containers are running in the correct Pods, and 
it communicates with the API server to manage the node's state.

-   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

**Kube-proxy**

A network proxy that maintains network rules on each node to enable communication between Pods, 
load balancing, and routing traffic.

-   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

**CRI**
~
The interface between Kubernetes and container runtimes (like Docker or containerd) that allows 
Kubernetes to run and manage containers on nodes.


_______________________________________________________________________________________________

**Deployment**

In Kubernetes, a Deployment is like a plan that tells Kubernetes how to run your app, including 
how many copies (Replicas) of it should run to handle user traffic.

_______________________________________________________________________________________________

**Service**

A Service is like a door that lets users or other apps find and connect to your app.

_______________________________________________________________________________________________

**config and secret yaml files**

Config and Secret are ways to store settings your app needs, like passwords (Secrets) or general 
settings (Config), and yes, these are often written in YAML files for easy readability and automation.

What features does Kubernetes have (actually):

**Service discovery and load balancing**
- Kubernetes is able to load balance and distribute the network traffic so that the 
deployment is stable.

**Storage orchestration**
- Kubernetes allows you to automatically mount a storage system of your choice, such 
as local storages, public cloud providers, and more.

**Automated rollouts and rollbacks**
- You can describe the desired state for your deployed containers using Kubernetes, 
and it can change the actual state to the desired state at a controlled rate. For example, 
you can automate Kubernetes to create new containers for your deployment, remove existing 
containers and adopt all their resources to the new container.

**Automatic bin packing**
- You provide Kubernetes with a cluster of nodes that it can use to run containerized tasks.
 You tell Kubernetes how much CPU and memory (RAM) each container needs. Kubernetes can fit 
 containers onto your nodes to make the best use of your resources.

**Self-healing**
- Kubernetes restarts containers that fail, replaces containers, kills containers that don't 
respond to your user-defined health check, and doesn't advertise them to clients until they 
are ready to serve.

**Secret and configuration management**
- Kubernetes lets you store and manage sensitive information, such as passwords, OAuth tokens, 
and SSH keys. You can deploy and update secrets and application configuration without rebuilding 
your container images, and without exposing secrets in your stack configuration.

**Batch execution**
- In addition to services, Kubernetes can manage your batch and CI workloads, replacing 
containers that fail, if desired.

**Horizontal scaling**
- Scale your application up and down with a simple command, with a UI, or automatically based on 
CPU usage.

**IPv4/IPv6 dual-stack**
- Allocation of IPv4 and IPv6 addresses to Pods and Services

**Designed for extensibility**
- Add features to your Kubernetes cluster without changing upstream source code.
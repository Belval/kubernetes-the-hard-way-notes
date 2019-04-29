# Provisioning Compute Resources

## Definitions

- Kubernetes structure
    - Control plane
        - Worker nodes
            - Containers
- Compute zone
    - GCP construct, a compute zone is a subspace of the region
- [Kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)
    - Node agent that runs on each node
- [Pod](https://kubernetes.io/docs/concepts/workloads/pods/pod/)
    - Group of one or more containers with shared storage/network, and a specification for how to run then containers.
    - Its content runs on a shared context
    - Containers within a pod share an IP address and can connect to eachother through `localhost`
- Instances
    - [Controller](https://kubernetes.io/docs/concepts/workloads/controllers/)
        - Is in charge of maintaining the pods? (TODO)
        - Actions
            - Create (I left the value used in because I think its easier to understand that way)
            ```
            gcloud compute instances create controller-${i} \
                --async \
                --boot-disk-size 200GB \
                --can-ip-forward \
                --image-family ubuntu-1804-lts \
                --image-project ubuntu-os-cloud \
                --machine-type n1-standard-1 \
                --private-network-ip 10.240.0.11 \
                --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
                --subnet kubernetes \
                --tags kubernetes-the-hard-way,controller
            ```
    - [Node/Worker](https://kubernetes.io/docs/concepts/architecture/nodes/)
        - A worker machine, previously known as a minion, may be a VM or a physical machine
        - Actions
            - Create  (I left the value used in because I think its easier to understand that way)
            ```
            gcloud compute instances create worker-${i} \
                --async \
                --boot-disk-size 200GB \
                --can-ip-forward \
                --image-family ubuntu-1804-lts \
                --image-project ubuntu-os-cloud \
                --machine-type n1-standard-1 \
                --metadata pod-cidr=10.200.${i}.0/24 \
                --private-network-ip 10.240.0.2${i} \
                --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
                --subnet kubernetes \
                --tags kubernetes-the-hard-way,worker
            ```
    - Actions
        - List: `gcloud compute instances list`
        - Setting up ssh: `gcloud compute ssh [INSTANCE_NAME]`
- [Networking model](https://kubernetes.io/docs/concepts/cluster-administration/networking/#kubernetes-model)
    - Every pod gets an IP
    - Pods can be treated like a VM or a physical host for
        - Port allocation
        - Naming
        - Service discovery
        - Load balancing
        - Application configuration
        - Migration
    - Pods on a node can communicate with all pods on all nodes without NAT
    - Agents on a node (system daemons, kubelet) can communicate with all pods on that node
    - Pods on the host network can communicate with all pods on all nodes without NAT
- [Virtual Private Cloud Network](https://cloud.google.com/vpc/docs/vpc#networks)
    - Network than can span across multiple regions
    - Defines a boundary for its content, you can define firewall rules for them
    - In the scope of the tutorial, this is for Google, but AWS has a VPC too, while Azure has VNet
    - Actions
        - Create: `gcloud compute networks create [NETWORK_NAME] --subnet-mode [SUBNET_MODE]`
- Subnet
    - Actions
        - Create: `gcloud compute subnets create [SUBNET_NAME] --network [NETWORK_NAME] --range [IP_RANGE]`
- Firewall
    - Does pretty much the same thing `iptable` does on a single machine
    - Actions
        - Create: `gcloud compute firewall-rules create [RULE_NAME] --allow [IP_LAYER_PROTOCOL] --network [NETWORK_NAME] --source-ranges [IP_RANGE],[SOMETHING?]`
            - You can specify ports in the allow by using `--allow tcp:22,tcp:443`
        - List: `gcloud compute firewall-rules list --filter="network:[NETWORK_NAME]"`
- Addresses
    - IP Addresses
    - Actions
        - Create: `gcloud compute addresses create [NETWORK_NAME] --region $(gcloud config get-value compute/region)`
        - Show static IP: `gcloud compute addresses list --filter="name=('[NETWORK_NAME]')"`
    
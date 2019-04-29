# Generating Kubernetes configuration files for authentication

- Kubernetes configuration files (kubeconfigs)
    - Enables the clients to locate and authenticate to the Kubernetes API servers
    - These files can be generated
    - They will connect through the Kubernetes Public IP address
        - That IP can be retrieve with: 
        ```sh
        KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
            --region $(gcloud config get-value compute/region) \
            --format 'value(address)')
        ```
    - The script `generate_configs.sh` essentially does 3 things
        - Set the cluster
        - Set the credentials
        - Set the context
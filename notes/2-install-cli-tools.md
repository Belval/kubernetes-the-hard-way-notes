# Install cli tools

- 3 tools
    - cfssl & cfssljson
        - Provided by Cloudflare
        - Tools to provision a PKI infrastructure and generate TLS certificates
            - A public key infrastructure (PKI) is a set of roles, policies, and procedures needed to create, manage, distribute, use, store & revoke digital certificates and manage public-key encryption - Wikipedia
        - Installed with the provided commands
            ```
            wget -q --show-progress --https-only --timestamping \
                https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
                https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
            chmod +x cfssl_linux-amd64 cfssljson_linux-amd64
            sudo mv cfssl_linux-amd64 /usr/local/bin/cfssl
            sudo mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
            ```
    - kubectl
        - CLI tool to run commands on a Kubernetes cluster
            - Deploy applications
            - Inspect & manage cluster resources, and view logs
        - Installed with `snap` but I suppose any method would do
# Bootstrapping the Kubernetes Workers

- Components
    - [`runc`](https://github.com/opencontainers/runc)
        - CLI tool for spawning and running containers according to the OCI specification.
    - [`gVisor`](https://github.com/google/gvisor)
        - Container runtime sandbox
        - Provides isolation boundary between host and applications
    - [Container networking plugins]()
        - Uses the Container Network Interface
            - Allows writing plugins to configure network interfaces in Linux containers
    - `containerd`
        - Docker container runtime
    - `kubelet`
        - Like the other 2 definitions already written
        - Node agent
    - `kube-proxy`
        - Proxy
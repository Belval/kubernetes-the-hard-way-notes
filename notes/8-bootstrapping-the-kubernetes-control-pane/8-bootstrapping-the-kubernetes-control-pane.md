# Bootstrapping the Kubernetes control pane

- Kubernetes API Server
    - Offers a REST frontend to the Kubernetes cluster shared state
- Kubernetes Controller Manager
    - Daemon with core loop
    - Regulates the system's state
    - Watches the shared state of the cluster through the API server
- Kubernetes Scheduler
    - Still not sure what this does
- RBAC (Role Based Access Control)
    - Set up can be done on only one controller
        - Why? TODO
- Kubernetes Frontend Load Balancer
    - TODO

## Notes

Somehow the script did not work the first time, only the second. Not quite sure why.
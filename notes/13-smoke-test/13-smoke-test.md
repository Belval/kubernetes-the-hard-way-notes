# Smoke test

Making sure that everything works

- Things to test
    - Data Encryption
        - What is a secret?
            - TODO
        - Check the data is encrypted at rest
        - Creating a secret
            - `kubectl create secret generic [cluster] --from-literal="[key]=[value]"`
        - It works if the key is prefixed with aescbc
    - Deployments
        - What is a deployment?
            - TODO
        - Check for the ability to do a deployment
    - Port forwarding
        - Test the ability to access applications remotely using port forwarding
    - Logs
    - Exec
    - Services
        - NodePort
        - This test fails
    - Untrusted Workloads
        - 
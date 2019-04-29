# Generating data encryption config key

- Allow encrypting cluster data at rest. These are called "Kubernetes Secrets"
- Look at the script but in short the steps are
    1. Generate an `ENCRYPTION_KEY` with `/dev/urandom` bytes
    2. Generate a `encryption-config.yaml` file containing the above key
    3. Upload it to every controller
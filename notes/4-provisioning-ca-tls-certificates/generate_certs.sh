
# CA
cfssl gencert -initca csr/ca-csr.json | cfssljson -bare certs/ca

# Admin
cfssl gencert -ca=certs/ca.pem \
              -ca-key=certs/ca-key.pem \
              -config=csr/ca-config.json \
              -profile=kubernetes csr/admin-csr.json | cfssljson -bare certs/admin

# Clients (script is long so I put it in another file)
./generate_workers_certs.sh

# Controller manager
cfssl gencert -ca=certs/ca.pem \
              -ca-key=certs/ca-key.pem \
              -config=csr/ca-config.json \
              -profile=kubernetes \
              csr/kube-controller-manager-csr.json | cfssljson -bare certs/kube-controller-manager

# Proxy
cfssl gencert -ca=certs/ca.pem \
              -ca-key=certs/ca-key.pem \
              -config=csr/ca-config.json \
              -profile=kubernetes \
              csr/kube-proxy-csr.json | cfssljson -bare certs/kube-proxy

# Scheduler
cfssl gencert -ca=certs/ca.pem \
              -ca-key=certs/ca-key.pem \
              -config=csr/ca-config.json \
              -profile=kubernetes \
              csr/kube-scheduler-csr.json | cfssljson -bare certs/kube-scheduler 

# API
KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

cfssl gencert -ca=certs/ca.pem \
              -ca-key=certs/ca-key.pem \
              -config=csr/ca-config.json \
              -hostname=10.32.0.1,10.240.0.10,10.240.0.11,10.240.0.12,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,kubernetes.default \
              -profile=kubernetes \
              csr/kubernetes-csr.json | cfssljson -bare certs/kubernetes

# Service account
cfssl gencert -ca=certs/ca.pem \
              -ca-key=certs/ca-key.pem \
              -config=csr/ca-config.json \
              -profile=kubernetes \
              csr/service-account-csr.json | cfssljson -bare certs/service-account
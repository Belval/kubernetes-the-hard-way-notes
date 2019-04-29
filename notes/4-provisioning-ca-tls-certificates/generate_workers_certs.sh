for instance in worker-0 worker-1 worker-2; do
cat > csr/${instance}-csr.json <<EOF
{
"CN": "system:node:${instance}",
"key": {
    "algo": "rsa",
    "size": 2048
},
"names": [
    {
    "C": "CA",
    "L": "Montreal",
    "O": "system:nodes",
    "OU": "Kubernetes The Hard Way",
    "ST": "Quebec"
    }
]
}
EOF

EXTERNAL_IP=$(gcloud compute instances describe ${instance} \
--format 'value(networkInterfaces[0].accessConfigs[0].natIP)')

INTERNAL_IP=$(gcloud compute instances describe ${instance} \
--format 'value(networkInterfaces[0].networkIP)')

cfssl gencert \
-ca=certs/ca.pem \
-ca-key=certs/ca-key.pem \
-config=csr/ca-config.json \
-hostname=${instance},${EXTERNAL_IP},${INTERNAL_IP} \
-profile=kubernetes \
csr/${instance}-csr.json | cfssljson -bare certs/${instance}
done
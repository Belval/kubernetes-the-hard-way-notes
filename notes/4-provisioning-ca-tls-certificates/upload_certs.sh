for instance in worker-0 worker-1 worker-2; do
  gcloud compute scp certs/ca.pem certs/${instance}-key.pem certs/${instance}.pem ${instance}:~/
done

for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp certs/ca.pem certs/ca-key.pem certs/kubernetes-key.pem certs/kubernetes.pem \
    certs/service-account-key.pem certs/service-account.pem ${instance}:~/
done
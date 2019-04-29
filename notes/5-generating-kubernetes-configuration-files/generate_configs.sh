cp -r ../4-provisioning-ca-tls-certificates/certs/ .

# Workers
echo "Workers"
{
  for instance in worker-0 worker-1 worker-2; do
    kubectl config set-cluster kubernetes-the-hard-way \
      --certificate-authority=certs/ca.pem \
      --embed-certs=true \
      --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
      --kubeconfig=kubeconfigs/${instance}.kubeconfig

    kubectl config set-credentials system:node:${instance} \
      --client-certificate=certs/${instance}.pem \
      --client-key=certs/${instance}-key.pem \
      --embed-certs=true \
      --kubeconfig=kubeconfigs/${instance}.kubeconfig

    kubectl config set-context default \
      --cluster=kubernetes-the-hard-way \
      --user=system:node:${instance} \
      --kubeconfig=kubeconfigs/${instance}.kubeconfig

    kubectl config use-context default --kubeconfig=kubeconfigs/${instance}.kubeconfig
  done
}

# kube-proxy
echo "kube-proxy"
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=certs/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=kubeconfigs/kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=certs/kube-proxy.pem \
    --client-key=certs/kube-proxy-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfigs/kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-proxy \
    --kubeconfig=kubeconfigs/kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=kubeconfigs/kube-proxy.kubeconfig
}

# kube-controller-manager
echo "kube-controller-manager"
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=certs/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kubeconfigs/kube-controller-manager.kubeconfig

  kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=certs/kube-controller-manager.pem \
    --client-key=certs/kube-controller-manager-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfigs/kube-controller-manager.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-controller-manager \
    --kubeconfig=kubeconfigs/kube-controller-manager.kubeconfig

  kubectl config use-context default --kubeconfig=kubeconfigs/kube-controller-manager.kubeconfig
}

# kube-scheduler
echo "kube-scheduler"
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=certs/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kubeconfigs/kube-scheduler.kubeconfig

  kubectl config set-credentials system:kube-scheduler \
    --client-certificate=certs/kube-scheduler.pem \
    --client-key=certs/kube-scheduler-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfigs/kube-scheduler.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-scheduler \
    --kubeconfig=kubeconfigs/kube-scheduler.kubeconfig

  kubectl config use-context default --kubeconfig=kubeconfigs/kube-scheduler.kubeconfig
}

# admin
echo "admin"
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=certs/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kubeconfigs/admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=certs/admin.pem \
    --client-key=certs/admin-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfigs/admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=kubeconfigs/admin.kubeconfig

  kubectl config use-context default --kubeconfig=kubeconfigs/admin.kubeconfig
}

# Distribute the kubeconfigs
## To the workers
for instance in worker-0 worker-1 worker-2; do
  gcloud compute scp kubeconfigs/${instance}.kubeconfig kubeconfigs/kube-proxy.kubeconfig ${instance}:~/
done

## To the controllers
for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp kubeconfigs/admin.kubeconfig kubeconfigs/kube-controller-manager.kubeconfig kubeconfigs/kube-scheduler.kubeconfig ${instance}:~/
done
for instance in worker-0 worker-1 worker-2; do
  gcloud compute ssh ${instance} --zone us-east1-c -- 'bash -s' < bootstrap_worker.sh
done

gcloud compute ssh controller-0 \
  --command "kubectl get nodes --kubeconfig admin.kubeconfig"
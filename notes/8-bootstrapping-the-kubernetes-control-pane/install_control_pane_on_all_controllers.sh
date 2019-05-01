for instance in controller-0 controller-1 controller-2; do
  gcloud compute ssh ${instance} --zone us-east1-c -- 'bash -s' < install_control_pane.sh
done
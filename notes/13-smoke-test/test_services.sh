# Expose nginx deployment using a NodePort service
kubectl expose deployment nginx --port 80 --type NodePort

# We get the port associated to the service
NODE_PORT=$(kubectl get svc nginx \
  --output=jsonpath='{range .spec.ports[0]}{.nodePort}')

# Create firewall rule to allow traffic
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-nginx-service \
  --allow=tcp:${NODE_PORT} \
  --network kubernetes-the-hard-way

# Retrieve the external IP address of a worker instance
# We do not use the LoadBalancer as that would require a cloud provider
# integration, which was considered out of scope for the tutorial.
EXTERNAL_IP=$(gcloud compute instances describe worker-0 \
  --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')

# Test HTTP request
curl -I http://${EXTERNAL_IP}:${NODE_PORT}
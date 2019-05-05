# We retrieve the name of the nginx pod created
# in the previous test
POD_NAME=$(kubectl get pods -l run=nginx -o jsonpath="{.items[0].metadata.name}")

# Get logs from the Nginx pod
kubectl logs $POD_NAME

# We retrieve the name of the nginx pod created
# in the previous test
POD_NAME=$(kubectl get pods -l run=nginx -o jsonpath="{.items[0].metadata.name}")

# Forwarding port 8080 of the local machine to port 80 of the pod
kubectl port-forward $POD_NAME 8080:80 &

sleep 5

# Test access
curl --head http://127.0.0.1:8080
# Deploy nginx webserver
kubectl run nginx --image=nginx

# list the pod created by the nginx deployment
kubectl get pods -l run=nginx




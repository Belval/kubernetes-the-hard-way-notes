# Deploy the add-on
kubectl apply -f https://storage.googleapis.com/kubernetes-the-hard-way/coredns.yaml

# List the pods
kubectl get pods -l k8s-app=kube-dns -n kube-system

# Verification
kubectl run busybox --image=busybox:1.28 --command -- sleep 3600
kubectl get pods -l run=busybox

# Retrieve the Busybox pod name
POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")

# Execute DNS lookup
kubectl exec -ti $POD_NAME -- nslookup kubernetes
# Create an untrusted pod
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: untrusted
  annotations:
    io.kubernetes.cri.untrusted-workload: "true"
spec:
  containers:
    - name: webserver
      image: gcr.io/hightowerlabs/helloworld:2.0.0
EOF

# Check that the untrusted pod is running
kubectl get pods -o wide

INSTANCE_NAME=$(kubectl get pod untrusted --output=jsonpath='{.spec.nodeName}')

# Check on the worker instance if it's running correctly
gcloud compute ssh ${INSTANCE_NAME} --zone us-east1-c -- 'bash -s' < test_untrusted_workloads_2.sh

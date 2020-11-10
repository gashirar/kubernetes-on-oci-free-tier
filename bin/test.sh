#!/bin/bash
set -ux

cd `dirname ${0}`
cd ..

WORKER_IP=$(terraform output -json -state=./terraform/terraform.tfstate | jq -r '.worker_ip.value')

kubectl apply -f ./example
kubectl wait --for=condition=Ready pod --all -n test

NGINX_NODEPORT=$(kubectl get svc -n test nginx -o=jsonpath='{.spec.ports[0].nodePort}')
HTTPD_NODEPORT=$(kubectl get svc -n test httpd -o=jsonpath='{.spec.ports[0].nodePort}')

curl -v  http://${WORKER_IP}:${NGINX_NODEPORT}
curl -v  http://${WORKER_IP}:${HTTPD_NODEPORT}

kubectl delete -f ./example
#!/bin/bash
set -eux

cd `dirname ${0}`
cd ../terraform

terraform init
terraform apply  -auto-approve -var-file=main.tfvars
terraform output

MASTER_IP=$(terraform output -json | jq -r '.master_ip.value')
MASTER_HOSTNAME=$(terraform output -json | jq -r '.master_hostname.value')
WORKER_IP=$(terraform output -json | jq -r '.worker_ip.value')
WORKER_HOSTNAME=$(terraform output -json | jq -r '.worker_hostname.value')
OS_USER=$(terraform output -json | jq -r '.os_user.value')

cat > ../ansible-kubeadm/hosts.ini << EOF
[master]
${MASTER_HOSTNAME} ansible_host=${MASTER_IP}

[worker]
${WORKER_HOSTNAME} ansible_host=${WORKER_IP}

[kube_cluster:children]
master
worker

[all:vars]
ansible_user=${OS_USER}
control_plane_endpoint_ip=${MASTER_IP}

EOF

cp ../ansible-kubeadm/hosts.ini ../ansible-k3s/hosts.ini
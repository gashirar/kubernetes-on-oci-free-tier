#!/bin/bash
set -eux

cd `dirname ${0}`

./terraform.sh
# Waiting Instance
sleep 30
./ansible-kubeadm.sh

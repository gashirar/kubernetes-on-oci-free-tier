#!/bin/bash
set -eux

cd `dirname ${0}`
cd ../ansible-kubeadm

ansible-playbook -i hosts.ini site.yaml
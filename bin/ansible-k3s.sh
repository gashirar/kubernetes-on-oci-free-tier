#!/bin/bash
set -eux

cd `dirname ${0}`
cd ../ansible-k3s

ansible-playbook -i hosts.ini site.yaml
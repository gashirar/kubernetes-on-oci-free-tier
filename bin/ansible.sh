#!/bin/bash
set -eux

cd `dirname ${0}`
cd ../ansible

ansible-playbook -i hosts.ini site.yaml
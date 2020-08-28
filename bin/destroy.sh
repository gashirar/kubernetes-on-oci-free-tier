#!/bin/bash
set -eux

cd `dirname ${0}`
cd ../terraform

terraform destroy -auto-approve -var-file=main.tfvars

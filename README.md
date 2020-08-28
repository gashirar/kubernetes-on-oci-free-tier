# kubernetes-on-oci-free-tier
Setup Kubernetes on OCI Free Tier

# Requirements

|Tool|Version|
|---|---|
|Terraform|0.12.26|
|Ansible|2.9.10|
|jq|1.6|

# How To

## Create main.tfvars

```bash
cp terraform/main.tfvars.example terraform/main.tfvars
```
Set the parameters.

## run Terraform

```
./bin/terraform.sh
```

## run Ansible Playbook
```bash
./bin/ansible.sh
```

## Set kubeconfig

```bash
mv ~/admin.conf ~/.kube/config
```

You are able to access Kubernetes Cluster.

## Destroy Cluster
```bash
./bin/destroy.sh
```
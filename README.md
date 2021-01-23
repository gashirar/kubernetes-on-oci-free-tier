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

## Create Cluster

### kubeadm
```bash
./bin/setup-by-kubeadm.sh
```

### k3s
```bash
./bin/setup-by-k3s.sh
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
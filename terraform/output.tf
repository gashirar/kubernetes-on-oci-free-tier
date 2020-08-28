output "master_ip" {
  value = oci_core_instance.master.public_ip
}

output "master_hostname" {
  value = oci_core_instance.master.hostname_label
}

output "worker_ip" {
  value = oci_core_instance.worker.public_ip
}

output "worker_hostname" {
  value = oci_core_instance.worker.hostname_label
}

output "os_user" {
  value = var.os_user
}
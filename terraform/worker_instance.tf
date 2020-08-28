resource "oci_core_instance" "worker" {
  availability_domain = lookup(data.oci_identity_availability_domains.all.availability_domains[0], "name")
  compartment_id      = var.compartment_ocid
  display_name        = "${var.cluster_name}-worker"

  source_details {
    source_id = var.image_id
    source_type = "image"
  }
  shape               = var.shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.worker.id
    display_name     = "Primaryvnic"
    assign_public_ip = true
    hostname_label   = "${var.cluster_name}-worker"
    nsg_ids          = [oci_core_network_security_group.worker.id]
  }

  extended_metadata = {
    roles               = "workers"
    ssh_authorized_keys = file(pathexpand(var.ssh_public_key_path))

    tags      = "group:worker"
  }

  freeform_tags = map("worker", "true")
}
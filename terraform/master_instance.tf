resource "oci_core_instance" "master" {
  availability_domain = lookup(data.oci_identity_availability_domains.all.availability_domains[0], "name")
  compartment_id      = var.compartment_ocid
  display_name        = "${var.cluster_name}-master"

  source_details {
    # Oracle-provided image "Oracle-Linux-7.8-2020.06.09-0"
    # https://docs.cloud.oracle.com/en-us/iaas/images/
    source_id = var.image_id
    source_type = "image"
  }
  shape               = var.shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.master.id
    display_name     = "Primaryvnic"
    assign_public_ip = true
    hostname_label   = "${var.cluster_name}-master"
    nsg_ids          = [oci_core_network_security_group.master.id]
  }

  extended_metadata = {
    roles               = "masters"
    ssh_authorized_keys = file(pathexpand(var.ssh_public_key_path))

    tags      = "group:master"
  }

  freeform_tags = map("master", "true")
}
resource "oci_core_virtual_network" "this" {
  cidr_block     = var.vcn_cidr_block
  dns_label      = "k8s"
  compartment_id = var.compartment_ocid
  display_name   = var.cluster_name
}

resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_ocid
  display_name   = "k8s"
  vcn_id         = oci_core_virtual_network.this.id
}

resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.this.id
  display_name   = "k8s"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.this.id
  }
}
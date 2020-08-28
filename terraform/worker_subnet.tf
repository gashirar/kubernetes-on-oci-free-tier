resource "oci_core_subnet" "worker" {
  availability_domain = lookup(data.oci_identity_availability_domains.all.availability_domains[0], "name")
  cidr_block = var.worker_subnet_cidr_block
  display_name = "${var.cluster_name}-worker"
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_virtual_network.this.id
  route_table_id = oci_core_route_table.route_table.id
  dns_label = "worker"
  dhcp_options_id = oci_core_virtual_network.this.default_dhcp_options_id
}

resource "oci_core_network_security_group" "master" {
  #Required
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.this.id
  #Optional
  display_name = "master"
}

resource "oci_core_network_security_group_security_rule" "master_egress" {
  network_security_group_id = oci_core_network_security_group.master.id
  direction                 = "EGRESS"
  destination               = "0.0.0.0/0"
  protocol                  = "all"
}

resource "oci_core_network_security_group_security_rule" "master_ingress_vcn" {
  network_security_group_id = oci_core_network_security_group.master.id
  direction                 = "INGRESS"
  source                    = var.vcn_cidr_block
  protocol                  = "all" # ALL
}

resource "oci_core_network_security_group_security_rule" "master_ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.master.id
  protocol                  = "6" # TCP
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "master_ingress_apiserver" {
  network_security_group_id = oci_core_network_security_group.master.id
  protocol                  = "6" # TCP
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}

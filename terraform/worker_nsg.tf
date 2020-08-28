resource "oci_core_network_security_group" "worker" {
  #Required
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.this.id
  #Optional
  display_name = "worker"
}

resource "oci_core_network_security_group_security_rule" "worker_egress" {
  network_security_group_id = oci_core_network_security_group.worker.id
  direction                 = "EGRESS"
  destination               = "0.0.0.0/0"
  protocol                  = "all"
}

resource "oci_core_network_security_group_security_rule" "worker_ingress_vcn" {
  network_security_group_id = oci_core_network_security_group.worker.id
  direction                 = "INGRESS"
  source                    = var.vcn_cidr_block
  protocol                  = "all"
}

resource "oci_core_network_security_group_security_rule" "worker_ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.worker.id
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

resource "oci_core_network_security_group_security_rule" "worker_ingress_nodeport" {
  network_security_group_id = oci_core_network_security_group.worker.id
  protocol                  = "6" # TCP
  direction                 = "INGRESS"
  source                    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 30000
      max = 32767
    }
  }
}

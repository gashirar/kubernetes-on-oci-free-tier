data "oci_identity_availability_domains" "all" {
  compartment_id = var.tenancy_ocid
}

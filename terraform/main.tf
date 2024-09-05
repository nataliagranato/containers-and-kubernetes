provider "oci" {}

resource "oci_core_vcn" "generated_oci_core_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name   = "oke-vcn-quick-oke-c3d6785cf"
  dns_label      = "oke"
}

resource "oci_core_internet_gateway" "generated_oci_core_internet_gateway" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name   = "oke-igw-quick-oke-c3d6785cf"
  enabled        = "true"
  vcn_id         = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_nat_gateway" "generated_oci_core_nat_gateway" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name   = "oke-ngw-quick-oke-c3d6785cf"
  vcn_id         = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_service_gateway" "generated_oci_core_service_gateway" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name   = "oke-sgw-quick-oke-c3d6785cf"
  services {
    service_id = "ocid1.service.oc1.iad.aaaaaaaam4zfmy2rjue6fmglumm3czgisxzrnvrwqeodtztg7hwa272mlfna"
  }
  vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_route_table" "generated_oci_core_route_table" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name   = "oke-private-routetable-oke-c3d6785cf"
  route_rules {
    description       = "traffic to the internet"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.generated_oci_core_nat_gateway.id
  }
  route_rules {
    description       = "traffic to OCI services"
    destination       = "all-iad-services-in-oracle-services-network"
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.generated_oci_core_service_gateway.id
  }
  vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_subnet" "service_lb_subnet" {
  cidr_block                 = "10.0.20.0/24"
  compartment_id             = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name               = "oke-svclbsubnet-quick-oke-c3d6785cf-regional"
  dns_label                  = "lbsub141ffc43e"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_default_route_table.generated_oci_core_default_route_table.id
  security_list_ids          = ["${oci_core_vcn.generated_oci_core_vcn.default_security_list_id}"]
  vcn_id                     = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_subnet" "node_subnet" {
  cidr_block                 = "10.0.10.0/24"
  compartment_id             = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name               = "oke-nodesubnet-quick-oke-c3d6785cf-regional"
  dns_label                  = "sub2b04a7daf"
  prohibit_public_ip_on_vnic = "true"
  route_table_id             = oci_core_route_table.generated_oci_core_route_table.id
  security_list_ids          = ["${oci_core_security_list.node_sec_list.id}"]
  vcn_id                     = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_subnet" "kubernetes_api_endpoint_subnet" {
  cidr_block                 = "10.0.0.0/28"
  compartment_id             = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name               = "oke-k8sApiEndpoint-subnet-quick-oke-c3d6785cf-regional"
  dns_label                  = "sub7d46c461b"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_default_route_table.generated_oci_core_default_route_table.id
  security_list_ids          = ["${oci_core_security_list.kubernetes_api_endpoint_sec_list.id}"]
  vcn_id                     = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_default_route_table" "generated_oci_core_default_route_table" {
  display_name = "oke-public-routetable-oke-c3d6785cf"
  route_rules {
    description       = "traffic to/from internet"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.generated_oci_core_internet_gateway.id
  }
  manage_default_resource_id = oci_core_vcn.generated_oci_core_vcn.default_route_table_id
}

resource "oci_core_security_list" "service_lb_sec_list" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name   = "oke-svclbseclist-quick-oke-c3d6785cf"
  vcn_id         = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_security_list" "node_sec_list" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name   = "oke-nodeseclist-quick-oke-c3d6785cf"
  egress_security_rules {
    description      = "Allow pods on one worker node to communicate with pods on other worker nodes"
    destination      = "10.0.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "Access to Kubernetes API Endpoint"
    destination      = "10.0.0.0/28"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "Kubernetes worker to control plane communication"
    destination      = "10.0.0.0/28"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "Path discovery"
    destination      = "10.0.0.0/28"
    destination_type = "CIDR_BLOCK"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    stateless = "false"
  }
  egress_security_rules {
    description      = "Allow nodes to communicate with OKE to ensure correct start-up and continued functioning"
    destination      = "all-iad-services-in-oracle-services-network"
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "ICMP Access from Kubernetes Control Plane"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    stateless = "false"
  }
  egress_security_rules {
    description      = "Worker Nodes access to Internet"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = "false"
  }
  ingress_security_rules {
    description = "Allow pods on one worker node to communicate with pods on other worker nodes"
    protocol    = "all"
    source      = "10.0.10.0/24"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Path discovery"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    source    = "10.0.0.0/28"
    stateless = "false"
  }
  ingress_security_rules {
    description = "TCP access from Kubernetes Control Plane"
    protocol    = "6"
    source      = "10.0.0.0/28"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Inbound SSH traffic to worker nodes"
    protocol    = "6"
    source      = "0.0.0.0/0"
    stateless   = "false"
  }
  vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_security_list" "kubernetes_api_endpoint_sec_list" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  display_name   = "oke-k8sApiEndpoint-quick-oke-c3d6785cf"
  egress_security_rules {
    description      = "Allow Kubernetes Control Plane to communicate with OKE"
    destination      = "all-iad-services-in-oracle-services-network"
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "All traffic to worker nodes"
    destination      = "10.0.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "Path discovery"
    destination      = "10.0.10.0/24"
    destination_type = "CIDR_BLOCK"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    stateless = "false"
  }
  ingress_security_rules {
    description = "External access to Kubernetes API endpoint"
    protocol    = "6"
    source      = "0.0.0.0/0"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Kubernetes worker to Kubernetes API endpoint communication"
    protocol    = "6"
    source      = "10.0.10.0/24"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Kubernetes worker to control plane communication"
    protocol    = "6"
    source      = "10.0.10.0/24"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Path discovery"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    source    = "10.0.10.0/24"
    stateless = "false"
  }
  vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_containerengine_cluster" "generated_oci_containerengine_cluster" {
  cluster_pod_network_options {
    cni_type = "OCI_VCN_IP_NATIVE"
  }
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  endpoint_config {
    is_public_ip_enabled = "true"
    subnet_id            = oci_core_subnet.kubernetes_api_endpoint_subnet.id
  }
  freeform_tags = {
    "OKEclusterName" = "oke"
  }
  kubernetes_version = "v1.30.1"
  name               = "oke"
  options {
    admission_controller_options {
      is_pod_security_policy_enabled = "false"
    }
    persistent_volume_config {
      freeform_tags = {
        "OKEclusterName" = "oke"
      }
    }
    service_lb_config {
      freeform_tags = {
        "OKEclusterName" = "oke"
      }
    }
    service_lb_subnet_ids = ["${oci_core_subnet.service_lb_subnet.id}"]
  }
  type   = "ENHANCED_CLUSTER"
  vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_containerengine_node_pool" "create_node_pool_details0" {
  cluster_id     = oci_containerengine_cluster.generated_oci_containerengine_cluster.id
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaouenl5dkovcw7niegbzakvve3denegzmxykgpvw7f4p24ee46epq"
  freeform_tags = {
    "OKEnodePoolName" = "pool1"
  }
  initial_node_labels {
    key   = "name"
    value = "oke"
  }
  kubernetes_version = "v1.30.1"
  name               = "pool1"
  node_config_details {
    freeform_tags = {
      "OKEnodePoolName" = "pool1"
    }
    node_pool_pod_network_option_details {
      cni_type = "OCI_VCN_IP_NATIVE"
    }
    placement_configs {
      availability_domain = "RkSf:US-ASHBURN-AD-1"
      subnet_id           = oci_core_subnet.node_subnet.id
    }
    placement_configs {
      availability_domain = "RkSf:US-ASHBURN-AD-2"
      subnet_id           = oci_core_subnet.node_subnet.id
    }
    placement_configs {
      availability_domain = "RkSf:US-ASHBURN-AD-3"
      subnet_id           = oci_core_subnet.node_subnet.id
    }
    size = "7"
  }
  node_eviction_node_pool_settings {
    eviction_grace_duration = "PT60M"
  }
  node_shape = "VM.Standard.E4.Flex"
  node_shape_config {
    memory_in_gbs = "16"
    ocpus         = "1"
  }
  node_source_details {
    image_id    = "ocid1.image.oc1.iad.aaaaaaaa3mw56urimjwfb2cpqzuqffk44nm5q27bm2r2qheiej43jwjp3wfa"
    source_type = "IMAGE"
  }
}

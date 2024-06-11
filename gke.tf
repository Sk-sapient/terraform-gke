resource "google_container_cluster" "primary" {
  name               = "private-gke-cluster"
  location           = var.region
  initial_node_count = 1

  network            = google_compute_network.custom_vpc.self_link
  subnetwork         = google_compute_subnetwork.custom_subnet.self_link

  remove_default_node_pool = true
  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "All networks"
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  network_policy {
    enabled = true
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    kubernetes_dashboard {
      disabled = true
    }
    network_policy_config {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    labels = {
      "env" = "dev"
    }

    tags = ["gke-node", "dev"]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

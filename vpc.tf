resource "google_compute_network" "custom_vpc" {
  name = var.network_name
}

resource "google_compute_subnetwork" "custom_subnet" {
  name          = var.subnet_name
  network       = google_compute_network.custom_vpc.name
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
}

variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "region" {
  description = "The region in which to provision resources."
  type        = string
  default     = "us-central1"
}

variable "zone" {
    type = string
    description = "Zone used to create node pool"
}

variable "network_name" {
  description = "The name of the VPC network to create."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet to create."
  type        = string
}

variable "cluster_name" {
    type = string
    description = "Name of the GKE Cluster"
}

variable "node_count" {
    type = number
    description = "No of nodes in cluster"
    default = 1
}

variable "machine_type" {
    type = string
    description = "Machine type used for GKE cluster"
    default = "e2-small"
}

variable "preemptibllity" {
    type = bool
    description = "Preamptiblity for machine used in node-pool"
    default = true
}



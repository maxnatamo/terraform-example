##
## Managed state
##

variable "remote_state_address" {
  type        = string
  description = "Remote state file address"
}

variable "remote_state_username" {
  type        = string
  description = "Username for querying remote state"
}

variable "remote_state_access_token" {
  type        = string
  description = "Access token for querying remote state"
}

##
## Kubernetes variables
##

variable "host" {
  type        = string
  description = "The IP-address and/or hostname of the Kubernetes cluster."
  default     = "https://127.0.0.1:6443"
}

variable "client_cert" {
  type        = string
  description = "The client certificate to authenticate with the Kubernetes cluster. Reference client-certificate-data."
}

variable "client_key" {
  type        = string
  description = "The client key to authenticate with the Kubernetes cluster. Reference client-key-data."
}

variable "cluster_ca_cert" {
  type        = string
  description = "The cluster certificate for the Kubernetes cluster. Reference certificate-authority-data."
}

##
## MetalLB
##

variable "metallb_addr_pool_name" {
  type        = string
  description = "The name of the default MetalLB address pool for load-balancers."
  default     = "og01-addr-pool"
}

variable "metallb_addr_pool_range" {
  type        = string
  description = "The IP-address range of the default MetalLB address pool for load-balancers."
  default     = "10.0.48.1-10.0.48.254"
}
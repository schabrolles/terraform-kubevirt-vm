## Basic VM Configuration Variables

variable "vm_name" {
  description = "Name of the bastion virtual machine"
  type        = string
  default     = "bastion"
}

variable "vm_namespace" {
  description = "Namespace where the VM will be deployed"
  type        = string
  default     = "default"
}

variable "vm_labels" {
  description = "Labels to apply to the VM"
  type        = map(string)
  default = {
    app  = "bastion"
    role = "infrastructure"
  }
}

## Resource Specifications

variable "memory_size" {
  description = "Amount of memory allocated to the VM"
  type        = string
  default     = "4Gi"
}

variable "cpu_sockets" {
  description = "Number of CPU sockets"
  type        = number
  default     = 2
}

variable "cpu_cores" {
  description = "Number of cores per socket"
  type        = number
  default     = 1
}

variable "cpu_threads" {
  description = "Number of threads per core"
  type        = number
  default     = 1
}

variable "cpu_model" {
  description = "CPU model to use"
  type        = string
  default     = "Westmere"
}

variable "root_disk_size" {
  description = "Size of the root disk"
  type        = string
  default     = "50Gi"
}

variable "storage_class" {
  description = "Classe de stockage pour le PVC"
  type        = string
  default     = "ocs-storagecluster-ceph-rbd"
}

## Base Image Configuration

variable "base_image_namespace" {
  description = "Namespace where the base image is stored"
  type        = string
  default     = "openshift-virtualization-os-images"
}

variable "base_image_name" {
  description = "Name of the base image to use for the VM"
  type        = string
  default     = "rhel9-base-image"
}

## Network Configuration

variable "network_name" {
  description = "Name of the network to attach to the VM"
  type        = string
  default     = "pod-network"
}

variable "interface_model" {
  description = "Network interface model"
  type        = string
  default     = "virtio"
}

variable "interface_type" {
  description = "Type of network interface"
  type        = string
  default     = "bridge"
}

variable "network_binding" {
  description = "Network binding method (default: masquerade for NAT)"
  type        = string
  default     = "masquerade"
}

## Cloud-Init Configuration

variable "ssh_public_key" {
  description = "SSH public key to add to authorized_keys for the default user"
  type        = string
  default     = ""
}

variable "cloud_user_password" {
  description = "Password for the cloud-user (leave empty to disable password auth)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "admin_user" {
  description = "Username for the admin user"
  type        = string
  default     = "cloud-user"
}

variable "timezone" {
  description = "Timezone to set on the VM"
  type        = string
  default     = "UTC"
}

variable "custom_user_data" {
  description = "Custom user-data to pass to cloud-init (base64 encoded)"
  type        = string
  default     = ""
}

variable "custom_network_data" {
  description = "Custom network-data to pass to cloud-init (base64 encoded)"
  type        = string
  default     = ""
}

variable "static_ip_configuration" {
  description = "Whether to use static IP configuration"
  type        = bool
  default     = false
}

variable "static_ip_address" {
  description = "Static IP address to assign to the VM (if static_ip_configuration is true)"
  type        = string
  default     = ""
}

variable "static_ip_netmask" {
  description = "Netmask for static IP configuration"
  type        = string
  default     = "24"
}

variable "static_ip_gateway" {
  description = "Gateway for static IP configuration"
  type        = string
  default     = ""
}

variable "dns_servers" {
  description = "List of DNS servers to use"
  type        = list(string)
  default     = []
}

## VM Runtime Configuration

variable "autostart" {
  description = "Whether to start the VM automatically"
  type        = bool
  default     = true
}

variable "running" {
  description = "Whether the VM should be in running state"
  type        = bool
  default     = true
}
variable "ocpvirt_host" {
  description = "Kubernetes API server host"
  type        = string
  default     = ""
}

variable "ocpvirt_token" {
  description = "Kubernetes API server token"
  type        = string
  default     = ""
}
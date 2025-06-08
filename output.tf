data "kubernetes_resource" "vmi_status" {
  api_version = "kubevirt.io/v1"
  kind        = "VirtualMachineInstance"

  metadata {
    name      = var.vm_name
    namespace = var.vm_namespace
  }

  depends_on = [
    null_resource.wait_for_vmi_IP
  ]
}

locals {
  # Extract IP address from VMI status
  vm_ip = try(
    data.kubernetes_resource.vmi_status.object.status.interfaces[0].ipAddress,
    var.static_ip_configuration ? var.static_ip_address : ""
  )
}

output "vm_namespace" {
  description = "The namespace of the virtual machine"
  value       = var.vm_namespace
}
output "vm_name" {
  description = "The name of the virtual machine"
  value       = var.vm_name
}
output "vm_ip" {
  description = "The IP address of the virtual machine"
  value       = local.vm_ip
}

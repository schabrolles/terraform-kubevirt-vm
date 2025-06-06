locals {
  # User data for cloud-init configuration
  user_data = var.custom_user_data != "" ? var.custom_user_data : <<-EOF
#cloud-config
hostname: ${var.vm_name}
user: ${var.admin_user}
%{if var.cloud_user_password != ""~}
password: ${var.cloud_user_password}
chpasswd:
  expire: false
ssh_pwauth: true
%{endif~}
ssh_authorized_keys:
  - ${var.ssh_public_key}
timezone: ${var.timezone}
package_update: true
package_upgrade: false
packages:
  - vim
  - curl
  - wget
  - tmux
runcmd:
  - echo "VM setup completed" > /var/log/vm-setup.log
EOF

  # Network data for cloud-init configuration
  network_data = var.custom_network_data != "" ? var.custom_network_data : <<-EOF
version: 2
ethernets:
  eth0:
    %{~if var.static_ip_configuration~}
    addresses:
      - ${var.static_ip_address}/${var.static_ip_netmask}
    gateway4: ${var.static_ip_gateway}
    nameservers:
      addresses: ${jsonencode(var.dns_servers)}
    %{~else~}
    dhcp4: true
    %{~endif~}
EOF
}

resource "kubectl_manifest" "kubevirt_vm" {
  wait_for {
    field {
      key   = "status.ready"
      value = "true"
    }
  }
  yaml_body = templatefile("${path.module}/templates/vm.yaml", {
    vm_name                 = var.vm_name
    vm_namespace            = var.vm_namespace
    cpu_cores               = var.cpu_cores
    memory_size             = var.memory_size
    base_image_name         = var.base_image_name
    base_image_namespace    = var.base_image_namespace
    cpu_sockets             = var.cpu_sockets
    cpu_threads             = var.cpu_threads
    cpu_model               = var.cpu_model
    root_disk_size          = var.root_disk_size
    network_name            = var.network_name
    interface_model         = var.interface_model
    interface_type          = var.interface_type
    network_binding         = var.network_binding
    ssh_public_key          = var.ssh_public_key
    admin_user              = var.admin_user
    cloud_user_password     = var.cloud_user_password
    timezone                = var.timezone
    static_ip_configuration = var.static_ip_configuration
    static_ip_address       = var.static_ip_address
    static_ip_netmask       = var.static_ip_netmask
    static_ip_gateway       = var.static_ip_gateway
    dns_servers             = var.dns_servers
    autostart               = var.autostart
    running                 = var.running
    custom_user_data        = var.custom_user_data
    custom_network_data     = var.custom_network_data
    vm_labels               = var.vm_labels
    storage_class           = var.storage_class
    user_data               = indent(12, local.user_data)
    network_data            = indent(12, local.network_data)
  })
}

resource "null_resource" "wait_for_vmi_IP" {
  depends_on = [
    kubectl_manifest.kubevirt_vm
  ]
  provisioner "local-exec" {
    command = <<EOT
    oc login --token=${var.ocpvirt_token} --server=${var.ocpvirt_host} --insecure-skip-tls-verify && until oc get vmi ${var.vm_name} -n ${var.vm_namespace} -o json | jq -e '.status.interfaces[0].ipAddress != "" and (.status.interfaces[0].ipAddress | length) > 8'; do
      sleep 5
    done
    EOT
  }
}

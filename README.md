## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 2.0.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.kubevirt_vm](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [null_resource.wait_for_vmi_IP](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [kubernetes_resource.vmi_status](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/resource) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | Username for the admin user | `string` | `"cloud-user"` | no |
| <a name="input_autostart"></a> [autostart](#input\_autostart) | Whether to start the VM automatically | `bool` | `true` | no |
| <a name="input_base_image_name"></a> [base\_image\_name](#input\_base\_image\_name) | Name of the base image to use for the VM | `string` | `"rhel9-base-image"` | no |
| <a name="input_base_image_namespace"></a> [base\_image\_namespace](#input\_base\_image\_namespace) | Namespace where the base image is stored | `string` | `"openshift-virtualization-os-images"` | no |
| <a name="input_cloud_user_password"></a> [cloud\_user\_password](#input\_cloud\_user\_password) | Password for the cloud-user (leave empty to disable password auth) | `string` | `""` | no |
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | Number of cores per socket | `number` | `1` | no |
| <a name="input_cpu_model"></a> [cpu\_model](#input\_cpu\_model) | CPU model to use | `string` | `"Westmere"` | no |
| <a name="input_cpu_sockets"></a> [cpu\_sockets](#input\_cpu\_sockets) | Number of CPU sockets | `number` | `2` | no |
| <a name="input_cpu_threads"></a> [cpu\_threads](#input\_cpu\_threads) | Number of threads per core | `number` | `1` | no |
| <a name="input_custom_network_data"></a> [custom\_network\_data](#input\_custom\_network\_data) | Custom network-data to pass to cloud-init (base64 encoded) | `string` | `""` | no |
| <a name="input_custom_user_data"></a> [custom\_user\_data](#input\_custom\_user\_data) | Custom user-data to pass to cloud-init (base64 encoded) | `string` | `""` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of DNS servers to use | `list(string)` | `[]` | no |
| <a name="input_interface_model"></a> [interface\_model](#input\_interface\_model) | Network interface model | `string` | `"virtio"` | no |
| <a name="input_interface_type"></a> [interface\_type](#input\_interface\_type) | Type of network interface | `string` | `"bridge"` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory allocated to the VM | `string` | `"4Gi"` | no |
| <a name="input_network_binding"></a> [network\_binding](#input\_network\_binding) | Network binding method (default: masquerade for NAT) | `string` | `"masquerade"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network to attach to the VM | `string` | `"pod-network"` | no |
| <a name="input_ocpvirt_host"></a> [ocpvirt\_host](#input\_ocpvirt\_host) | Kubernetes API server host | `string` | `""` | no |
| <a name="input_ocpvirt_token"></a> [ocpvirt\_token](#input\_ocpvirt\_token) | Kubernetes API server token | `string` | `""` | no |
| <a name="input_root_disk_size"></a> [root\_disk\_size](#input\_root\_disk\_size) | Size of the root disk | `string` | `"50Gi"` | no |
| <a name="input_running"></a> [running](#input\_running) | Whether the VM should be in running state | `bool` | `true` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key to add to authorized\_keys for the default user | `string` | `""` | no |
| <a name="input_static_ip_address"></a> [static\_ip\_address](#input\_static\_ip\_address) | Static IP address to assign to the VM (if static\_ip\_configuration is true) | `string` | `""` | no |
| <a name="input_static_ip_configuration"></a> [static\_ip\_configuration](#input\_static\_ip\_configuration) | Whether to use static IP configuration | `bool` | `false` | no |
| <a name="input_static_ip_gateway"></a> [static\_ip\_gateway](#input\_static\_ip\_gateway) | Gateway for static IP configuration | `string` | `""` | no |
| <a name="input_static_ip_netmask"></a> [static\_ip\_netmask](#input\_static\_ip\_netmask) | Netmask for static IP configuration | `string` | `"24"` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Classe de stockage pour le PVC | `string` | `"ocs-storagecluster-ceph-rbd"` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone to set on the VM | `string` | `"UTC"` | no |
| <a name="input_vm_labels"></a> [vm\_labels](#input\_vm\_labels) | Labels to apply to the VM | `map(string)` | <pre>{<br/>  "app": "bastion",<br/>  "role": "infrastructure"<br/>}</pre> | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of the bastion virtual machine | `string` | `"bastion"` | no |
| <a name="input_vm_namespace"></a> [vm\_namespace](#input\_vm\_namespace) | Namespace where the VM will be deployed | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_ip"></a> [vm\_ip](#output\_vm\_ip) | The IP address of the virtual machine |

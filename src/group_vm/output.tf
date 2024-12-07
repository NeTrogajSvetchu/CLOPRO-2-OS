
output "target_group_id" {

 value = yandex_compute_instance_group.group-vms.load_balancer[0].target_group_id
  
}

output "group_wm1" {
  
  value = yandex_compute_instance_group.group-vms.instances.0.network_interface.0.ip_address
}

output "group_wm2" {
  
  value = yandex_compute_instance_group.group-vms.instances.1.network_interface.0.ip_address
}

output "group_wm3" {
  
  value = yandex_compute_instance_group.group-vms.instances.2.network_interface.0.ip_address
}
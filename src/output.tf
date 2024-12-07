/*
output "all_vms" {
  value = [
    for instance in yandex_compute_instance_group.group-vms.instances : {
      name = instance.name
      ip_internal = instance.network_interface[0].ip_address
      ip_external = instance.network_interface[0].nat_ip_address}
  ]
}
*/
output "Picture_URL" {
  value = "https://${module.backet-1.bucked}/${module.backet-1.picture_key}"
  description = "Адрес загруженной в бакет картинки"
}

output "Network_Load_Balancer_Address" {
  value = module.load_balancer.ip_netb
  description = "Адрес сетевого балансировщика"
}

output "Application_Load_Balancer_Address" {
  value = module.application_balancer.ip_appb
  description = "Адрес L7-балансировщика"
}

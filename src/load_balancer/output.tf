output "ip_netb" {
  value = yandex_lb_network_load_balancer.balancer.listener.*.external_address_spec[0].*.address
}

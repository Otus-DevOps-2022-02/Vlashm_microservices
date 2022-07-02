output "external_ip_address_reddit_docker" {
  value = "${yandex_compute_instance.reddit_docker[*].network_interface.0.nat_ip_address}"
}

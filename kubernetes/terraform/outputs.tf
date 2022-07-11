output "external_ip_address_k8s_master" {
  value = yandex_compute_instance.k8s_master.network_interface.0.nat_ip_address
}
output "external_ip_address_k8s_worker" {
  value = yandex_compute_instance.k8s_worker.network_interface.0.nat_ip_address
}

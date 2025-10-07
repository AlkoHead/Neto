output "vm_external_ips" {
  value = [
    for vm in yandex_compute_instance.platform : vm.network_interface[0].nat_ip_address
  ]
  description = "Внешние IP-адреса всех созданных ВМ"
}

output "vm_internal_ips" {
  value = [
    for vm in yandex_compute_instance.platform : vm.network_interface[0].ip_address
  ]
  description = "Внутренние IP-адреса всех созданных ВМ"
}

output "vm_names" {
  value = [
    for vm in yandex_compute_instance.platform : vm.name
  ]
  description = "Имена всех созданных ВМ"
}
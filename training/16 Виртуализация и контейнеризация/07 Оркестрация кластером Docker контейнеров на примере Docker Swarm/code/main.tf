resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# VM
resource "yandex_compute_instance" "platform" {
  count = length(var.vm_names)   # Добавляем count для создания 3 ВМ

  name = var.vm_names[count.index]  # берём имена из переменных
  hostname = var.vm_names[count.index]

  platform_id = var.vm_web_standart
  resources {
    cores = var.vms_resources.web.cores
    memory = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vms_resources.web.hdd_size
      type = var.vms_resources.web.hdd_type
    }
  }
  scheduling_policy {

    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = var.vm_web_nat
  }

    metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

}
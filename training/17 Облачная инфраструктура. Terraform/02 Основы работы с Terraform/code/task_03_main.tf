resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

## подсеть для db

resource "yandex_vpc_subnet" "db" {
  name = var.vm_vpc_db_name
  zone = var.vm_db_zone
  network_id = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_cidr
}

data "yandex_compute_image" "ubuntu" {
#  family = "ubuntu-2004-lts"
  family = var.vm_web_family
}

resource "yandex_compute_instance" "platform" {
#  name        = "netology-develop-platform-web"
  name = var.vm_web_name
#  platform_id = "standard-v1"
  platform_id = var.vm_web_standart
  resources {
  #  cores         = 2
    cores = var.vm_web_cores
  #  memory        = 1
    memory  = var.vm_web_memory
  #  core_fraction = 5
    core_fraction = var.vm_web_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
  #  preemptible = true
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
  #  nat       = true
    nat = var.vm_web_nat
  }

  metadata = {
  #  serial-port-enable = 1
    serial-port-enable = var.vm_web_serial
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
 
}

#  Задание 3

resource "yandex_compute_instance" "platform_db" {
  name = var.vm_db_name
  platform_id = var.vm_db_platform
  zone = var.vm_db_zone
  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.db.id
    nat       = var.vm_db_nat
  }

    metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}

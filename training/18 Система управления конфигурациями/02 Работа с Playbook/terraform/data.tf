# Data sources для образов ОС
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}
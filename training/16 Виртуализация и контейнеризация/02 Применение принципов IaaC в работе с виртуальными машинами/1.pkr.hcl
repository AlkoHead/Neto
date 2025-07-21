source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "XXXXXXXXXXXXXX"
  image_description   = "Debian 11 with Docker and Docker Compose"
  image_name          = "debian-11-docker-v2"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "XXXXXXXXXXXXXXX"
  token               = "XXXXXXXXXXXXXXX"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get upgrade -y"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common",       
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "sudo usermod -aG docker debian"
    ]
  }

}
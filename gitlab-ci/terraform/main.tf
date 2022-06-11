provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "gitlab" {
  name = "gitlab"
  zone = var.zone

  labels = {
    tags = "gitlab"
  }

  resources {
    cores  = 2
    memory = 6
  }

  boot_disk {
    initialize_params {
      size     = 50
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.gitlab_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "yandex_vpc_network" "gitlab_net" {
  name = "gitlab_net"
}

resource "yandex_vpc_subnet" "gitlab_subnet" {
  name           = "gitlab_subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.gitlab_net.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

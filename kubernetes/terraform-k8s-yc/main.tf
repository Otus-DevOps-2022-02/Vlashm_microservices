provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_kubernetes_cluster" "reddit_cluster" {
  name               = "reddit-cluster"
  folder_id                = var.folder_id
  network_id         = var.network_id
  service_account_id = var.service_account_id
  node_service_account_id = var.node_service_account_id
  release_channel = "RAPID"


  master {
    version = "1.19"
    public_ip = true

    zonal {
      zone      = var.zone_kube_cluster
      subnet_id = var.subnet_id
    }
  }
}

resource "yandex_kubernetes_node_group" "reddit_groups" {

  cluster_id = yandex_kubernetes_cluster.reddit_cluster.id
  name       = "reddit-groups"
  version    = "1.19"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat        = true
      subnet_ids = [var.subnet_id]
    }

    metadata = {
      ssh-keys = "ubuntu:${file(var.public_key_path)}"
    }

    resources {
      cores  = 4
      memory = 8
    }

    boot_disk {
      size = 64
      type = "network-ssd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }
}

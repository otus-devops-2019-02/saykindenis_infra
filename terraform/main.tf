terraform {
  # Версия terraform
  # required_version = "0.11.11"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"

  # ID проекта
  project = "${var.project}"

  region = "${var.region}"
}

resource "google_compute_project_metadata_item" "ssh-keys" {
  key   = "ssh-keys"
  value = "appuser2:${file("${var.public_key_path}")} appuser3:${file("${var.public_key_path}")} appuser4:${file("${var.public_key_path}")}"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  tags = ["reddit-app"]

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # название сети, в которой действует правило
  network = "default"

  # какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # правило применяется для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}

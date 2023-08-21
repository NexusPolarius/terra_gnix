locals {
  ssh_key = "ubuntu:${file("~/.ssh/gnix.pub")}"
}

resource "yandex_vpc_network" "vpc_1" {
  # folder_id = var.folder_id
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnet_1" {
  # folder_id = var.folder_id
  v4_cidr_blocks = var.subnet_cidrs
  zone           = var.zone
  name           = var.subnet_name
  network_id = yandex_vpc_network.vpc_1.id
}

resource "yandex_compute_instance" "instance" {
  name        = var.vm_name
  hostname    = var.vm_name
  platform_id = var.platform_id
  zone        = var.zone
  # folder_id   = var.folder_id
  resources {
    cores         = var.cpu
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet_1.id
    nat                = var.nat
    ip_address         = var.internal_ip_address
    nat_ip_address     = var.nat_ip_address
  }

  metadata = {
    ssh-keys           = local.ssh_key
  }
  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/gnix")
    host        = yandex_compute_instance.instance.network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = ["echo 'Im ready!'"]

  }

  provisioner "local-exec" {
    command = "ansible-playbook --private-key ~/.ssh/gnix -u ubuntu -i '${self.network_interface.0.nat_ip_address},' provision.yml"
  }
   
}


output "internal_ip_address_instance" {
  value = yandex_compute_instance.instance.network_interface.0.ip_address
}


output "external_ip_address_instance" {
  value = yandex_compute_instance.instance.network_interface.0.nat_ip_address
}

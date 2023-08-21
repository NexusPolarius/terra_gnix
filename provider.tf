locals {
  cloud_id           = "b1gfk7gprebc7f59853i"
  folder_id          = "b1grbn39sme6dq8b4sjo" #otus-labs
  zone               = "ru-central1-a"
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}


provider "yandex" {
  cloud_id  = local.cloud_id
  folder_id = local.folder_id
}

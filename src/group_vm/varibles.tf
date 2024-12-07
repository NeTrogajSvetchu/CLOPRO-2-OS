###cloud vars


variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "id" {
  
}

variable "subnet_ids" {
  
}

variable "bucket" {
  
}
variable "yandex_compute_instance_groupvms" {
  type        = list(object({
    name = string
    cores = number
    memory = number
    core_fraction = number
    platform_id = string
  }))

  default = [
    {
      name = "gr-1"
      cores         = 2
      memory        = 2
      core_fraction = 5
      platform_id = "standard-v1"
    }
    /*,
    {
      name = "gr-2"
      cores         = 2
      memory        = 2
      core_fraction = 5
      platform_id = "standard-v1"
    },
    {
      name = "gr-3"
      cores         = 2
      memory        = 2
      core_fraction = 5
      platform_id = "standard-v1"
    }
    */
    ]
}

variable "boot_disk" {
  type        = list(object({
    size = number
    type = string
    image_id = string
    }))
    default = [ {
    size = 10
    type = "network-hdd"
    image_id = "fd827b91d99psvq5fjit"
  }]
}
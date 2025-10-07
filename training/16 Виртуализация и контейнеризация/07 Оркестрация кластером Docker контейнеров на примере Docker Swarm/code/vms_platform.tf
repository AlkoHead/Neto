variable "vm_web_family" {
  type = string
  default = "ubuntu-2004-lts"
}

# variable "vm_web_name" {
#   type = string
#   default = "my_test"
# }

variable "vm_web_standart" {
  type = string
  default = "standard-v1"
}

variable "vm_web_preemptible" {
  type = bool
  default = true
}

variable "vm_web_nat" {
  type = bool
  default = true  
}

# Задаём имя ВМ
variable "vm_names" {
  type = list(string)
  default = [ 
    "master-01",
    "slave-01",
    "slave-02"
   ]
}

# VM характеристики
variable "vms_resources" {
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      hdd_size      = 10
      hdd_type      = "network-hdd"
    }
    # db = {
    #   cores         = 2
    #   memory        = 2
    #   core_fraction = 20
    #   hdd_size      = 50
    #   hdd_type      = "network-ssd"
    # }
  }
}

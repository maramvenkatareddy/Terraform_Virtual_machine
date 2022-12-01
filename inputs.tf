variable "resource_group_details" {
    type = object ({
        name = string
        location = string
    })

  
}

variable "publicips" {
  type = list(string)
}

variable "nics" {
    type = list(string)
  
}

variable "virtual_network_details" {
    type = object ({
        name = string
        address_space = list(string)
    })
  
}

variable "subnet_details" {
    type = list(string)
  
}

variable "vms" {
    type = list(string)
}

variable "authentication_details" {
   type = object({
    username = string
    password = string
   })
}

variable "VmSize" {
    type = string
  
}
variable "nsgs" {
    type = string
  
}
variable "disk_name" {
    type = list(string)
  
}
variable "null_version" {
    type = string
  
}
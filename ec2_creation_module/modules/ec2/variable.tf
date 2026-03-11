variable "security_group_name" {}

variable "security_group_ports" {
  description = "firewall ports"
  type        = list(number)
}

variable "ami_id" {}
variable "server_instance_type" {}
variable "server_key_name" {}
variable "instance_name" {}



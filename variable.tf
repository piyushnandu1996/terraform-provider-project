variable "my_instance_name" {
  description = "instance name"
  type        = string
}


variable "secutrity_group_ports" {
  description = "ports to add in security group"
  default     = [22, 80, 443]

}
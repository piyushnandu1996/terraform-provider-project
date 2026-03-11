variable "firewall_ports" {
  description = "adding ports to security group"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}

variable "instance_name" {
  description = "name of instance"
  type        = list(string)
  default     = ["dolat-capital", "barclay", "jp-morgan"]
}
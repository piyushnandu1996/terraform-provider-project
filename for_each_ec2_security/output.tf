output "instance_name" {
  description = "name of instance"
  value       = var.instance_name
}

output "instance_type" {
  description = "type of instance"
  value       = [for i in aws_instance.redhat-ec2 : i.instance_type]
}




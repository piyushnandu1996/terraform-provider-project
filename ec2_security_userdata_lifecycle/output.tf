output "instance-name" {
  description = "name of instance"
  value       = aws_instance.dolat_instance.tags.Name

}
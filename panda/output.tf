output "public_ip" {
  description = "public ip of instance"
  value       = aws_instance.panda_backup.public_ip
}

output "elastic_ip" {
  description = "elastic ip of instance"
  value       = aws_eip.panda_eip.public_ip
}

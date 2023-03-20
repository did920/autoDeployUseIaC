output "public_ip" {
  description = "public ip of instance"
  value       = aws_instance.center2_backup.public_ip
}

output "elastic_ip" {
  description = "elastic ip of instance"
  value       = aws_eip.center2_eip.public_ip
}

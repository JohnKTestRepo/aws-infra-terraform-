output "ec2_public_ip" {
  description = "Public IP of the Apache EC2 instance"
  value       = module.ec2_apache.public_ip
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.security_group.sg_id
}


variable "ami_filter_name" {
  description = "AMI name filter for Amazon Linux 2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "vpc_security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "user_data" {
  description = "User data script content"
  type        = string
}

variable "server_name" {
  description = "Tag name for the EC2 server"
  type        = string
}

variable "private_key_path" {
  description = "Path to SSH private key for remote exec"
  type        = string
}


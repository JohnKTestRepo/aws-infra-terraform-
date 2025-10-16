variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-2"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "my_public_ip" {
  type        = string
  description = "Provide Your PC's Public IP eg. 104.194.51.113/32"
}

variable "private_key_path" {
  description = "Path to the private key to be used for ssh access"
  type        = string
}

variable "public_key" {
  type        = string
  description = "The public key to be used for the instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
}

variable "server_name" {
  description = "Tag Name for the EC2 server"
  type = string
}

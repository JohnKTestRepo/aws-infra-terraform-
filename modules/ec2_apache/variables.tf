variable "ami_filter_name" {}
variable "instance_type" {}
variable "key_name" {}
variable "vpc_security_groups" {
  type = list(string)
}
variable "user_data" {}
variable "server_name" {}
variable "private_key_path" {}

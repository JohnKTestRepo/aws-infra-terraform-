data "aws_vpc" "main" {
  id = var.vpc_id
}

data "template_file" "user_data" {
  template = file("${path.module}/userdata.yaml")
}

module "key_pair" {
  source     = "./modules/key_pair"
  key_name   = "deployer-key"
  public_key = var.public_key
}

module "security_group" {
  source       = "./modules/security_group"
  vpc_id       = data.aws_vpc.main.id
  my_public_ip = var.my_public_ip
}

module "ec2_apache" {
  source              = "./modules/ec2_apache"
  ami_filter_name     = "amzn2-ami-hvm*"
  instance_type       = var.instance_type
  key_name            = module.key_pair.key_name
  vpc_security_groups = [module.security_group.sg_id]
  user_data           = data.template_file.user_data.rendered
  server_name         = var.server_name
  private_key_path    = var.private_key_path
}


data "aws_ami" "east_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = [var.ami_filter_name]
  }
}

resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.east_amazon_linux_2.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_groups
  user_data              = var.user_data

  provisioner "remote-exec" {
    inline = [
      "echo ${self.private_ip} >> /home/ec2-user/private_ips.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file(var.private_key_path)
    }
  }

  tags = {
    Name = var.server_name
  }
}



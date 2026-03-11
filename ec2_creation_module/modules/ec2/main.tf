resource "random_string" "postfix" {
  length  = 5
  upper   = false
  special = false
}

resource "aws_security_group" "firewall_rules" {
  name = var.security_group_name

  dynamic "ingress" {
    for_each = var.security_group_ports

    content {
      description = "Allowing incoming ports"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "server" {

  ami                    = var.ami_id
  instance_type          = var.server_instance_type
  key_name               = var.server_key_name
  vpc_security_group_ids = [aws_security_group.firewall_rules.id]

  tags = {
    Name = var.instance_name
  }

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
        #!/bin/bash
        sudo hostnamectl set-hostname "PIYUSH-TERRAFORM"
        apt-get update -y
        apt-get install nginx -y
        systemctl start nginx
        systemctl enable nginx


    EOF
}

resource "random_string" "uniq_string" {
  length  = 4
  upper   = false
  special = false
}

resource "aws_security_group" "dolat_security_group" {
  name = "SIGNAL-BSE"


  dynamic "ingress" {
    for_each = var.secutrity_group_ports
    content {
      description = "TLS from VPC"
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

  tags = {
    Name = "SIGNAL-BSE"
  }
}

resource "aws_instance" "dolat_instance" {
  ami                    = "ami-019715e0d74f695be"
  key_name               = "git"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.dolat_security_group.id]

  lifecycle {
    prevent_destroy  = true
  }

  user_data = <<-EOF
    #!/bin/bash

    #Installing apache
    apt-get update -y 
    apt-get install nginx -y
    systemctl start nginx.service
    systemctl enable nginx.service
    echo "<h1>Welcome Piyush</h1>" > /var/www/html/index.html

    EOF



  tags = {
    Name = "${var.my_instance_name}-${random_string.uniq_string.result}"
  }
}
# Creating random number (Ity will be attached with ec2 redhat)
resource "random_string" "uniq_string" {
  length  = 4
  upper   = false
  special = false
}

# Defining security group rules (firewall)
resource "aws_security_group" "firewall_rules" {
  name = "redhat-firewall-rules"

  dynamic "ingress" {
    for_each = var.firewall_ports
    content {
      description = "Incomming port allow"
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

# Creating EC2 redhat instance

resource "aws_instance" "redhat-ec2" {
  for_each               = toset(var.instance_name)
  ami                    = "ami-0ffef61f6dc37ae89"
  key_name               = "git"
  region                 = "ap-south-1"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.firewall_rules.id]


  tags = {
    Name = "${each.value}-${random_string.uniq_string.result}"
  }

  lifecycle {
    create_before_destroy = true
  }


  user_data = <<-EOF
                #!/bin/bash
                yum update -y 
                yum install httpd -y
                systemctl start httpd
                systemctl enable httpd
                echo "<h1>Welcome To Dolat Capital<h1>" >/var/www/html/index.html
            EOF

}
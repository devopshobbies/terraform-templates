terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.62.0"
    }
  }
}

resource "aws_instance" "apache_webserver" {
  ami = var.ami_id
  instance_type = var.web_instance_type
  key_name = "aws_key"
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data =  <<-EOF
      #!/bin/sh
      sudo apt-get update
      sudp apt install -y apache2
      sudo systemctl status apache2
      sudo systemctl start apache2
      sudo chown -R $USER:USER /var/www/html
      sudo rcho "<html><body><h1> This is module </h1></body></html>"
      EOF
}


resource "aws_security_group" "main" {
    name = "appache-webserver"
    description = "main rules for publishing server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1
    to_port     = 8
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
}

resource "aws_key_pair" "deployer" {
    key_name = "aws_key"
    public_key = "ssh-rsa XXXXXXXXXXX"
}
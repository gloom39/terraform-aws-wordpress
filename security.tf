resource "aws_security_group" "wordpress" {
  name        = "wordpress"
  description = "Allow ssh and http inbound traffic and all outbound traffic"
  vpc_id      = data.aws_subnets.all_subnets.ids[0]
  tags = {
    Name = "wordpress"
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "allow-mariadb" {
  name = "allow-maridb"
  description = "allow-mariadb"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 3306
    to_port = 3306
    protocol ="tcp"
    security_groups = [aws_security_group.wordpress.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "MariaDB"
  }
}

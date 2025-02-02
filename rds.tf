resource "aws_db_parameter_group" "mariadb-parameters" {
  name = "mariadb-parameters"
  family = "mariadb11.4"
  description = "MariaDB parameter group"
}

resource "aws_db_subnet_group" "mariadb-subnet" {
  name = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids = data.aws_subnets.all_subnets.ids
}

resource "aws_db_instance" "wordpressdb" {
  allocated_storage = "30"
  engine = "mariadb"
  instance_class = "db.t3.micro"
  identifier = "wordpress"
  username = var.db_username
  password = var.db_password
  db_name = var.db_name
  db_subnet_group_name = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name = aws_db_parameter_group.mariadb-parameters.name
  multi_az = "false"
  vpc_security_group_ids = [aws_security_group.allow-mariadb.id]
  storage_type = "gp2"
  backup_retention_period = 0
  skip_final_snapshot = true
  tags = {
    Name = "mariadb-instance"
  }
}

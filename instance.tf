resource "aws_instance" "wordpress" {
   ami = var.ami
   instance_type = var.instance_type
   subnet_id = aws_subnet.main-public-1.id
   tags = {
     Name = "wordpress"
   }
   vpc_security_group_ids = [ aws_security_group.wordpress.id ]
   key_name = aws_key_pair.wordpress.key_name

   provisioner "file" {
      source = "scripts/setup.sh"
      destination = "/home/ubuntu/setup.sh"
    }
   
   connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/keys/wordpress.pem")
      host = self.public_ip
    }

    provisioner "remote-exec" {
      inline = [
        "export dbhost=${aws_db_instance.wordpressdb.address}",
        "export dbname=${var.db_name}",
        "export dbuser=${var.db_username}",
        "export dbpass=${var.db_password}",
        "export ip=${aws_instance.wordpress.public_ip}",
        "export title=${var.wp_title}",
        "export admin_name=${var.wp_admin_user}",
        "export admin_password=${var.wp_admin_pass}",
        "export admin_email=${var.wp_admin_email}",
        "bash /home/ubuntu/setup.sh >> setup.log 2>&1"
      ]
    }
    
   depends_on = [ aws_db_instance.wordpressdb ]
}


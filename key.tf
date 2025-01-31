resource "aws_key_pair" "wordpress" {
  key_name   = "wordpress"
  public_key = file("${path.module}/keys/wordpress.pub")
}
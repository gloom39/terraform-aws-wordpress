data "aws_ami" "ubuntu" {
   filter  {
     name = "name"
     values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20250115"]
   }
}

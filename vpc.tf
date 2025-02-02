# Default VPC
data "aws_vpc" "default" {
  default = true
}

# Default subnet
data "aws_subnets" "all_subnets" {
   filter {
     name = "vpc-id"
     values = [data.aws_vpc.default.id]
   }
}

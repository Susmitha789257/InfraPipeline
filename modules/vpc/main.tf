resource "aws_vpc" "osaka_vpc" {
  cidr_block = "12.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Todayvpc"
  }
}

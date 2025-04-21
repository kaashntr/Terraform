resource "aws_vpc" "terra-demo" {
  cidr_block = "10.1.0.0/21"
  enable_dns_hostnames = true
  tags = {
    Name = "terra-demo"
  }
}

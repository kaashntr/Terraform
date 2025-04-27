 resource "aws_subnet" "terra-demo-public-subnet" {
  vpc_id     = aws_vpc.terra-demo.id
  cidr_block = "10.1.0.0/23"
  map_public_ip_on_launch = true
  tags = {
    Name = "terra-demo-public-subnet"
  }
}
 resource "aws_subnet" "terra-demo-private-subnet" {
  vpc_id     = aws_vpc.terra-demo.id
  cidr_block = "10.1.4.0/23"

  tags = {
    Name = "terra-demo-private-subnet"
  }
}
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
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.terraform_vpc.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private_route_table.id, aws_route_table.public_route_table.id]
}
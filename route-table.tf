resource "aws_route_table" "public" {
  vpc_id = aws_vpc.terra-demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-demo-igw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.terra-demo.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terra-demo-nat-gateway.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.terra-demo-public-subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.terra-demo-private-subnet.id
  route_table_id = aws_route_table.private.id
}
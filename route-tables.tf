resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.terra-demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-demo-igw.id
  }
  tags = {
    Name = "public"
  }
  depends_on = [ aws_internet_gateway.terra-demo-igw ]
}
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.terra-demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.terra-demo-nat-gateway.id
  }
  tags = {
    Name = "private"
  }
  depends_on = [ aws_nat_gateway.terra-demo-nat-gateway ]
}
resource "aws_route_table_association" "public-route-table-association" {
  subnet_id      = aws_subnet.terra-demo-public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
  depends_on = [ aws_route_table.public-route-table ]
}
resource "aws_route_table_association" "private-route-table-association" {
  subnet_id      = aws_subnet.terra-demo-private-subnet.id
  route_table_id = aws_route_table.private-route-table.id
  depends_on = [ aws_route_table.private-route-table ]
}
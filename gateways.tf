resource "aws_internet_gateway" "terra-demo-igw" {
  vpc_id = aws_vpc.terra-demo.id

  tags = {
    Name = "terra-demo-igw"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "terra-demo-nat-gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.terra-demo-public-subnet.id

  tags = {
    Name = "terra-demo-nat-gateway"
  }

  depends_on = [aws_internet_gateway.terra-demo-igw]
}
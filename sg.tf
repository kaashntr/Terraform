resource "aws_security_group" "lt-sg" {
  vpc_id = aws_vpc.terra-demo.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.terra-demo-private-subnet.cidr_block]
    description = "SSH access from private subnet"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.terra-demo-private-subnet.cidr_block]
    description = "HTTP access from private subnet"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
}
resource "aws_security_group" "elb-sg" {
  vpc_id = aws_vpc.terra-demo.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
    description = "HTTP access from public internet"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
}
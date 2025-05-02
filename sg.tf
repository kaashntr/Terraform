resource "aws_security_group" "ec2" {
  name        = "ec2"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.terra-demo.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "31.128.191.250/32"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "public" {
  name = "allow_all"
  vpc_id = aws_vpc.terra-demo.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}
resource "aws_security_group" "private" {
  name = "allow_public"
  vpc_id = aws_vpc.terra-demo.id
  ingress {
    cidr_blocks = [aws_subnet.terra-demo-public-subnet.cidr_block] 
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1" 
  }
  
}
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "public-key" {
  key_name   = "public-key"
  public_key = tls_private_key.key.public_key_openssh
}
resource "local_file" "private_key" {
  content  = tls_private_key.key.private_key_pem
  filename = "${path.module}/key.pem"
  file_permission = "0600"
}


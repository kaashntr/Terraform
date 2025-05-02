resource "aws_instance" "demo" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"               

  
  key_name = aws_key_pair.public-key.key_name          
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  
  vpc_security_group_ids = [aws_security_group.ec2.id]
  subnet_id            = aws_subnet.terra-demo-public-subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "FreeTierEC2"
  }
}
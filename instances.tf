data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_instance" "public_instance" {
  ami                    = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.terra-demo-public-subnet.id
  associate_public_ip_address = true
  key_name               = "public-key"
  vpc_security_group_ids = [aws_security_group.public.id]

  tags = {
    Name = "UbuntuPublicInstance"
  }
  depends_on = [ aws_key_pair.public-key, aws_security_group.public, aws_subnet.terra-demo-public-subnet, aws_vpc.terra-demo]
}
resource "aws_instance" "private_instance" {
  ami                    = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.terra-demo-private-subnet.id
  key_name               = "public-key"
  vpc_security_group_ids = [aws_security_group.private.id]
  tags = {
    Name = "UbuntuPrivateInstance"
  }
  depends_on = [ aws_key_pair.public-key, aws_security_group.private, aws_subnet.terra-demo-private-subnet, aws_vpc.terra-demo]
}

output "public_instance_public_ip" {
  value = aws_instance.public_instance.public_ip
}
output "private_instance_private_ip" {
  value = aws_instance.private_instance.private_ip
}




resource "aws_instance" "free_tier_example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"               

  
  key_name = aws_key_pair.public-key.key_name          
  
  
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  subnet_id            = aws_subnet.terra-demo-public-subnet.id
  associate_public_ip_address = true

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update
              EOF
  )

  tags = {
    Name = "FreeTierEC2"
  }
}
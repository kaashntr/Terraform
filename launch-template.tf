resource "aws_launch_template" "launch_template" {
  image_id      = "ami-084568db4383264d4"
  instance_type = "t2.micro"

  key_name = aws_key_pair.public-key.key_name
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.private.id]
  }
  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get -y update
    apt-get -y install nginx
    systemctl start nginx
    systemctl enable nginx
    echo "Hello from ASG instance!" > /var/www/html/index.html
    EOF
  )
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "FreeTierInstance"
    }
  }
}
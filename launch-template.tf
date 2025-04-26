resource "aws_launch_template" "launch_template" {
  image_id      = "ami-084568db4383264d4"
  instance_type = "t2.micro"

  key_name = aws_key_pair.public-key.key_name
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.private.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "FreeTierInstance"
    }
  }
}
data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}
resource "aws_launch_template" "lt" {
  name_prefix   = "template"
  image_id      = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type = "t2.micro"

  key_name = aws_key_pair.public-key.key_name
  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get -y update
              apt-get -y install nginx
              echo "Hello, World!" > /var/www/html/index.html
              systemctl start nginx
              EOF
  )
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.lt-sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "FreeTierUbuntu"
    }
  }
}

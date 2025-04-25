data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}
resource "aws_launch_template" "launch_template" {
  name_prefix   = "launch_template"
  image_id      = aws_ssm_parameter.ubuntu_ami.value
  instance_type = "t2.micro"

  key_name = "your-key-name" # Replace with your actual key pair name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = ["sg-xxxxxxxx"] # Replace with your security group
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "FreeTierInstance"
    }
  }
}
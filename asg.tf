resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  desired_capacity          = 2
  max_size                  = 1
  min_size                  = 3
  vpc_zone_identifier       = [aws_subnet.terra-demo-private-subnet.id] 

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  force_delete              = true
  wait_for_capacity_timeout = "0"
}
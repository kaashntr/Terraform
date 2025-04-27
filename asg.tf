resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = [aws_subnet.terra-demo-private-subnet.id] 
  target_group_arns = [aws_lb_target_group.nlb_target.arn]
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  force_delete              = true
  wait_for_capacity_timeout = "0"
}
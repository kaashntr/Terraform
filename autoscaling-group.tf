resource "aws_autoscaling_group" "asg" {
  name                      = "free-tier-asg"
  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 1
  vpc_zone_identifier       = [aws_subnet.terra-demo-private-subnet.id]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.nlb_target.arn]
  tag {
    key                 = "Name"
    value               = "FreeTierASG"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  force_delete              = true
  wait_for_capacity_timeout = "0"
}
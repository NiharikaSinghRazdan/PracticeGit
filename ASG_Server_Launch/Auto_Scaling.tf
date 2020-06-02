resource "aws_autoscaling_group" "InstanceScaling" {
  max_size             = 2
  min_size             = 1
  desired_capacity     = 2
  force_delete         = true
  launch_configuration = aws_launch_configuration.LaunchConfig.name
  name                 = "InstanceScaling"
  availability_zones   = ["us-east-1a", "us-east-1b"]

}

resource "aws_autoscaling_policy" "ScalingPolicy" {
  name                   = "ScalingPolicy"
  autoscaling_group_name = aws_autoscaling_group.InstanceScaling.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  }
}
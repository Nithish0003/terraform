provider "aws" {
  region = "ap-south-1" 
}

resource "aws_sns_topic" "notify" {
  name = "topic-1"
}

resource "aws_sns_topic_subscription" "notify" {
  topic_arn = aws_sns_topic.notify.arn
  protocol  = "email"
  endpoint  = "nits000333@gmail.com"  
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization" {
  alarm_name          = "high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"  
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "monitors server-5 CPU Utilization"
  dimensions = {
    InstanceId = "i-07988c7d00378a5e6"
  }
  alarm_actions = [
    "arn:aws:sns:ap-south-1:767397679814:topic-1"  
  ]
}
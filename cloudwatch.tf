
# Step 1: Set up AWS CloudWatch Logs
resource "aws_cloudwatch_log_group" "security_logs" {
  name = "/aws/security"
}
# Step 2: Configure AWS CloudTrail
resource "aws_cloudtrail" "example" {
  name                          = "example-cloudtrail"
  s3_bucket_name                = "your-s3-bucket-name"
  is_multi_region_trail         = true
  is_organization_trail         = false
  enable_log_file_validation     = true
  include_global_service_events = true
  cloudwatch_logs_group_arn     = aws_cloudwatch_log_group.security_logs.arn
  cloudwatch_logs_role_arn      = aws_iam_role.cloudtrail_role.arn
}
# Step 5: Create AWS CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "example_alarm" {
  alarm_name          = "example-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name         = "ExampleMetric"
  namespace           = "ExampleNamespace"
  period              = 60
  statistic           = "SampleCount"
  threshold           = 1
  alarm_description   = "Example CloudWatch Alarm"
  alarm_actions       = [aws_sns_topic.example_sns_topic.arn]
}

resource "aws_sns_topic" "example_sns_topic" {
  name = "example-sns-topic"
}
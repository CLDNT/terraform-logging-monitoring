# Step 3: Create IAM Role for CloudTrail
resource "aws_iam_role" "cloudtrail_role" {
  name = "cloudtrail-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "cloudtrail_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudTrail_CloudWatchLogs"
  role       = aws_iam_role.cloudtrail_role.name
}

# Step 4: Create AWS Config Rule(s)
resource "aws_config_rule" "example_rule" {
  name        = "example-config-rule"
  description = "Example AWS Config rule"
  
  source {
    owner             = "CUSTOM_LAMBDA"
    source_identifier = "arn:aws:lambda:us-east-1:123456789012:function/example-lambda"
  }
}
# Create IAM Role for Lambda Function
resource "aws_iam_role" "lambda_role" {
  name        = "lambda_role"
  description = "Lambda Role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
# Create IAM Policy for Lambda Function
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy"
  description = "Lambda Policy"

  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "ec2:StartInstances",
      "Resource": "${aws_instance.rds_vpc_instance["rds-vpc-test-1"].arn}",
      "Effect": "Allow"
    },
    {
      "Action": "ec2:StopInstances",
      "Resource": "${aws_instance.rds_vpc_instance["rds-vpc-test-1"].arn}",
      "Effect": "Allow"
    }
  ]
}
EOF
}
# Attach IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
data "archive_file" "arc_1" {
  type        = "zip"
  source_file = "start-instance.py"
  output_path = "start_instance.zip"
}
data "archive_file" "arc_2" {
  type        = "zip"
  source_file = "stop-instance.py"
  output_path = "stop_instance.zip"
}
# Create Lambda Function
resource "aws_lambda_function" "lambda_function1" {
  filename      = "start-instance.zip"
  function_name = "start_instance"
  handler       = "index.handler"
  # runtime       = "nodejs14.x"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_role.arn
  environment {
    variables = {
      INSTANCE_ID = aws_instance.vpc2_instance["vpc2-test-1"].id
    }
  }
}
resource "aws_lambda_function" "lambda_function2" {
  filename      = "stop-instance.zip"
  function_name = "Stop_instance"
  handler       = "index.handler"
  # runtime       = "nodejs14.x"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_role.arn
  environment {
    variables = {
      INSTANCE_ID = aws_instance.vpc2_instance["vpc2-test-1"].id
    }
  }
}
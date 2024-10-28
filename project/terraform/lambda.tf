# Lambda Layer provisioning before Lambda function
resource "aws_lambda_layer_version" "common_lambda_layer" {
  layer_name = "commonLambdaLayer"
  filename = "commonLambdaLayer.zip"
  compatible_runtimes = [var.python_runtime]
}


# Provision of Lambda and the function to be used
resource "aws_lambda_function" "s3_write" {
  function_name = "s3_write_${var.env}"
  role          = aws_iam_role.test_lambda_execution_role.arn
  handler = "src.lambda.s3_write.lambda_function.lambda_handler"
  filename = "s3_write.zip"
  source_code_hash = filebase64sha256("s3_write.zip")
  runtime = var.python_runtime
  memory_size = var.lambda_s3_write_memory_size_mb
  timeout = var.lambda_s3_write_timeout_seconds
  layers = [aws_lambda_layer_version.common_lambda_layer.arn]

  environment {
    variables = {
      S3_BUCKET = "<<Your bucket Name>>"  # Assuming that S3 bucket exists
      LOG_LEVEL = var.lambda_s3_write_log_level
    }
  }

  tags = merge(
    local.tags,
    {
      "ResourceName" = "s3_write_${var.env}"
    }
  )

}


# Provision of Lambda event source mapping -> Lambda polls SQS "test" for messages;
# Frequency of polling is determined by batch_size and maximum_batching_window_in_seconds
resource "aws_lambda_event_source_mapping" "test_queue" {
  event_source_arn = module.sqs_test.arn
  function_name    = aws_lambda_function.s3_write.arn
  enabled = true
  batch_size = var.lambda_s3_write_event_source_mapping_batch_size
  maximum_batching_window_in_seconds = var.lambda_s3_write_event_source_mapping_batching_window_in_seconds
}


# Provision lambda execution role with the required permissions
resource "aws_iam_role" "test_lambda_execution_role" {
  name = "TestLambdaExecutionRole_${var.env}"

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

  path                 = "/CustomerManaged/"
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/BasicRole_Boundary"
}

# TODO: Add proper permission to read from SQS and write to S3 bucket
resource "aws_iam_role_policy" "TestLambdaRolePolicy" {
  name = "TestLambdaRolePolicy"
  role   = aws_iam_role.test_lambda_execution_role.id

  policy =<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
          {
            "Action": [
                "sqs:ChangeMessageVisibility",
                "sqs:DeleteMessage",
                "sqs:GetQueueAttributes",
                "sqs:GetQueueUrl",
                "sqs:ReceiveMessage"
            ],
            "Resource": [
                "${module.sqs_test.arn}"
            ],
            "Effect": "Allow"
        }
]
}
EOF
}
provider "aws" {
  region  = var.aws_region
}

data "aws_caller_identity" "current" {}

# SQS configuration is module-based! When we have large number of resources to be created, grouping resources into modules avoids clutter.
# For simple architectures and infra provisions, configuring in the root module, again with some grouping is fine! Look at lambda.tf file.
module "sqs_test" {
  source = "modules/sqs_test"

  env  = var.env
  test_queue_max_message_size = var.test_queue_max_message_size
  test_queue_message_retention_seconds = var.test_queue_message_retention_seconds
  test_queue_visibility_timeout_seconds = var.test_queue_visibility_timeout_seconds
  test_dlq_max_receive_count = var.test_dlq_max_receive_count

# Merge common tags with resource-specific tags
  tags = merge(
    local.tags,
    {
      "ResourceName" = "test_${var.env}"
    }
  )
}
# Not possible to initiate mock_provider as "AWS" in the main.tftest and then use resource-specific ".tftest.hcl" files
# unlike with ".tf" file
mock_provider "aws" {
  alias = "mock"

  # In-place of a dummy ARN, create a default ARN value that conforms to ARN regex pattern verified by Terraform during resource creation
  mock_resource "aws_sqs_queue"{
    defaults = {
      arn  = "arn:aws:sqs:us-east-1:123456789012:test_mock_sqs"
    }
  }

  # In-place of a dummy AWS account, create a default account value that conforms to regex pattern verified by Terraform during resource creation
  mock_data "aws_caller_identity" {
    defaults = {
      account_id = "123456789012"
    }
  }

  mock_resource "aws_lambda_function"{
    defaults = {
      arn  = "arn:aws:lambda:us-east-1:123456789012:function:test_mock_lambda"
    }
  }

  mock_resource "aws_iam_role"{
    defaults = {
      arn  = "arn:aws:iam::123456789012:role/test_mock_role"
    }
  }

  mock_resource "aws_lambda_layer_version"{
    defaults = {
      arn  = "arn:aws:lambda:us-east-1:123456789012:layer:test_mock_layer"
    }
  }
}

# Mock Test for SQS resource creation
run "sqs-mock-test" {
  providers = {
    aws = aws.mock
  }
  variables {
    env  = "mock"
    test_queue_max_message_size = 1024
  }
  assert {
    condition     = module.sqs_test.name == "test_mock"
    error_message = "The SQS queue name did not match the expected value"
  }
  assert {
    condition     = module.sqs_test.max_message_size == 1024
    error_message = "Configured max_message_size did not match the expected value"
  }
}

# Mock Test for SQS DLQ resource creation
run "sqs-dlq-mock-test" {
  providers = {
    aws = aws.mock
  }
  variables {
    env  = "mock"
  }
  assert {
    condition     = module.sqs_test.dlq_name == "test_dlq_mock"
    error_message = "Configured DLQ name did not match the expected value"
  }
}


run "lambda-mock-test" {
  providers = {
    aws = aws.mock
  }
  variables {
    python_runtime = "python3.10"
  }
  assert {
    condition     = aws_lambda_function.s3_write.runtime == "python3.10"
    error_message = "The Lambda function's python runtime did not match the expected value"
  }
}
# DLQ for Tes Queue
resource "aws_sqs_queue" "test_dlq" {
  name = "test_dlq_${var.env}"
  max_message_size = var.test_queue_max_message_size
  message_retention_seconds = var.test_queue_message_retention_seconds
  visibility_timeout_seconds = var.test_queue_visibility_timeout_seconds
}

# SQS "test" configuration
resource "aws_sqs_queue" "test" {
  name                       = "test_${var.env}"
  max_message_size           = var.test_queue_max_message_size
  message_retention_seconds  = var.test_queue_message_retention_seconds
  visibility_timeout_seconds = var.test_queue_visibility_timeout_seconds
  sqs_managed_sse_enabled    = true  # Encryption at rest

  redrive_policy = <<POLICY
  {
    "deadLetterTargetArn": "${aws_sqs_queue.test_dlq.arn}",
    "maxReceiveCount": ${var.test_dlq_max_receive_count}
  }
  POLICY
}


# Resource Level policy;
resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.test.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:*",
      "Resource": "${aws_sqs_queue.test.arn}"
    }
  ]
}
POLICY

}
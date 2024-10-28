# Outputs are the way to communicate the module's output with root module of terraform and for mock testing
output "arn" {
  value = aws_sqs_queue.test.arn
}
output "name" {
  value = aws_sqs_queue.test.name
}
output "max_message_size" {
  value = aws_sqs_queue.test.max_message_size
}
output "dlq_name" {
  value = aws_sqs_queue.test_dlq.name
}
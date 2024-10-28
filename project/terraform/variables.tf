# Purpose: Declare the variables that will be used in the terraform configuration.
# The actual values of the variables are configured based on environment used and generally provided using the ".tfvars" file.
# (ex: dev.tfvars, test.tfvars, prod.tfvars)
variable "aws_region" {}
variable "env" {}
variable "test_dlq_max_receive_count" {}
variable "test_queue_max_message_size" {}
variable "test_queue_message_retention_seconds" {}
variable "test_queue_visibility_timeout_seconds" {}
variable "lambda_s3_write_log_level" {}
variable "lambda_s3_write_timeout_seconds" {}
variable "lambda_s3_write_event_source_mapping_batch_size" {}
variable "lambda_s3_write_event_source_mapping_batching_window_in_seconds" {}
variable "python_runtime" {}
variable "lambda_s3_write_memory_size_mb" {}
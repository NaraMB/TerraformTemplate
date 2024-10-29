# Variables are the inputs to the module. Good practice is to initialize here and configure the actual values in the root module for flexibility
variable "tags" {
  type = map(string)
  description = "A map of common tags to be merged with resource-specific tags"
}

variable "env" {}
variable "test_queue_max_message_size" {}
variable "test_queue_message_retention_seconds" {}
variable "test_queue_visibility_timeout_seconds" {}
variable "test_dlq_max_receive_count" {}

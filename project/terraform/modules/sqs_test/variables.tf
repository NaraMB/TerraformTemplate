# Variables are the inputs of the module that is used to initialize here and the actual values being configured in the root module for flexibility
# So, important to use them as inputs to the root module
variable "tags" {
  type = map(string)
  description = "A map of common tags to be merged with resource-specific tags"
}

variable "env" {}
variable "test_queue_max_message_size" {}
variable "test_queue_message_retention_seconds" {}
variable "test_queue_visibility_timeout_seconds" {}
variable "test_dlq_max_receive_count" {}
aws_region = "us-east-1"
env = "dev"  # env is the environment that is generally followed such as dev or prod or test
test_dlq_max_receive_count = 4
test_queue_max_message_size = 262144
test_queue_message_retention_seconds = 345600
test_queue_visibility_timeout_seconds = 960
lambda_s3_write_log_level = "INFO"
lambda_s3_write_timeout_seconds = 900
lambda_s3_write_memory_size_mb = 128
lambda_s3_write_event_source_mapping_batch_size = 10
lambda_s3_write_event_source_mapping_batching_window_in_seconds = 10
python_runtime = "python3.8"
# Initializing the remote state backend
# # While I am giving an example as an S3 bucket, it could be any reliable/fault tolerant storage.
# This is only initialization. As the best practice, the actual state file is configured using ".tfbackend" file and used during terraform init.
terraform {
  backend "s3" {}
}
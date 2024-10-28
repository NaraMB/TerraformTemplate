# The Lambda layer generally includes dependency packages such as boto3, botocore, etc.
# Dependencies are maintained in the requirements.txt file or using a tool like poetry.
# The Lambda layer could be shared across multiple Lambda functions. The purpose of the lambda layer is to not load all
# dependencies in the Lambda function code dynamically but to have them pre-installed in the Lambda layer.


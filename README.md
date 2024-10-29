## Terraform Template for AWS
This repo is a template for real world use case. It uses terraform and Github actions to automate the infrastructure provisions on AWS.

Some features of the repo include:
1. showcase of modules to avoid clutter in the root terraform module (see SQS provisioning)
2. showcase of non-modular, simple grouping of resources in the root terraform module when there is minimal provisioning (see Lambda Provisioning)
3. Differentiate configurations for development and production environments
4. Using mock tests to mimic AWS resource creation and catch any issues locally before the actual deployment
5. Terraform best practices such as linting, security checks
6. Github actions to automate the infrastructure deployment

## Installations
Any IDE supporting python and terraform can be used.

It's preferable to install terraform locally and play with some tutorials. 
Install terraform locally from documentation here: [terraform installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


## Terraform tutorials
If you're a beginner or yet to learn terraform basics, strongly recommended to complete terraform tutorial from documentation. As an example:

1. Learn about basics of terraform provisioning with AWS [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)
2. Learn about basics of terraform provisioning with docker [here](https://developer.hashicorp.com/terraform/tutorials/docker-get-started)


### Terraform Modules
In simpler terms, modules are like functions in programming. 
You create re-usable code (configurations in TF) wrapped in a function 
(module) and communicate with the function through input 
(variable in terraform) and output (output in terraform) parameters.

Terraform modules are one of the most elegant ways of grouping the 
resources. It helps in avoiding clutter in the root module and makes 
the code more readable and maintainable especially with large projects.

Terraform also recommends to use modules cautiously without causing too
many nested blocks!
In real world scenario, one module per resource or a group of resources
is a good practice depending on the complexity of the project.

Learn about basics of terraform modules [here](https://learn.hashicorp.com/tutorials/terraform/module)

[Developing terraform modules](https://developer.hashicorp.com/terraform/language/modules/develop/composition)



### Mock Tests with Terraform
Mock tests with newer versions of terraform has been very handy in being able 
to mimic AWS resource creation with dummy ARNs. This makes sure that the configurations
are correct before the actual provision.

In place of dummy values, we have to use default values for any specific 
resource during mock tests. For example, we have to create default ARN 
value for a SQS provision, that conforms to a regex pattern verified by
terraform.
This helps greatly in completing integration test using mocking behavior.
Check out the tests folder for more details.

Learn about using mock tests [here](https://developer.hashicorp.com/terraform/language/tests/mocking)



## Usage
This is just a template and need to make few modifications to be able to use it!

1. Make sure to use your AWS Account in the GitHub workflow file
2. Make sure to set up proper IAM permissions for your Lambda and SQS
3. Provisioning of resources works with the above 2 steps itself! If you want to test the resources, you can use the below steps
4. Use AWS SDK (boto3) to send simple messages to SQS, which Lambda polls and consumes!
5. Also, if required, write a simple lambda function to read messages from SQS and print it to cloudwatch logs/write to S3!. (Lambda has a generous free tier for personal needs!)


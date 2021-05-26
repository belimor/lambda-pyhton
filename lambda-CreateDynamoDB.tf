module "Create-DynamoDB-Lambda" {
  source = "./modules/lambda"

  function_name = "CreateDynamoDB"
  description   = "Create DynamoDB Lambda Function"
  aws_project   = var.aws_project
  project_tags  = var.project_tags
}

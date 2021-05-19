module "Hello-World-Lambda" {
  source        = "./modules/lambda"

  function_name = "HelloWorld"
  description   = "Hello World Lambda Function"
  aws_project   = var.aws_project
  project_tags  = var.project_tags
}

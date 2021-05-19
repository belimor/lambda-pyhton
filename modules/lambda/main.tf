resource "aws_lambda_function" "this" {
  function_name                  = var.function_name
  description                    = var.description
  role                           = var.create_role
  handler                        = var.package_type
  runtime                        = var.package_type
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  publish                        = var.publish
  layers                         = var.layers
  image_uri                      = var.image_uri
  package_type                   = var.package_type

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }

  tags = merge(
    var.project_tags,
    {
      project = var.aws_project
    }
  )

  depends_on = [aws_cloudwatch_log_group.lambda]
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.cloudwatch_logs_retention_in_days

  tags = merge(var.tags, var.cloudwatch_logs_tags)
}

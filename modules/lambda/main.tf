data "archive_file" "Lambda-Archive" {
  type        = "zip"
  source_dir  = "${path.module}/${var.function_name}"
  output_path = "${path.module}/tmp/${var.function_name}.zip"
}

resource "aws_lambda_function" "this" {
  function_name                  = var.function_name
  description                    = var.description
  role                           = var.role
  handler                        = "lambda_function.lambda_handler"
  runtime                        = "python3.8"
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  #publish                        = var.publish
  
  filename                        = data.archive_file.Lambda-Archive.output_path
  
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

  tags = merge(
    var.project_tags,
    {
      project = var.aws_project
    }
  )
}

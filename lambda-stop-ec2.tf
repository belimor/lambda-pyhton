#######################
# Lambda-StopEC2
#######################

data "archive_file" "Lambda-StopEC2-Archive" {
  type        = "zip"
  source_dir  = "${path.module}/StopEC2"
  output_path = "${path.module}/tmp/StopEC2.zip"
}

resource "aws_lambda_function" "Lambda-StopEC2" {

  function_name = "${var.aws_project}-Lambda-StopEC2"
  description   = "Lambda-StopEC2"
  filename      = data.archive_file.Lambda-StopEC2-Archive.output_path
  runtime       = "python3.8"
  role          = aws_iam_role.Lambda-StopEC2-Role.arn
  handler       = "lambda_function.lambda_handler"
  timeout       = 30
  publish       = false

  environment {
    variables = {
      Project = var.aws_project
    }
  }

  tags = merge(
    var.project_tags,
    {
      project = var.aws_project
    }
  )
}

resource "aws_cloudwatch_log_group" "Lambda-StopEC2-LogGroup" {
  name              = "/aws/lambda/${var.aws_project}-Lambda-StopEC2"
  retention_in_days = 3

  tags = merge(
    var.project_tags,
    {
      project = var.aws_project
    }
  )
}

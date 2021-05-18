#######################
# Lambda-Python
#######################

data "archive_file" "Lambda-CreateEC2-Archive" {
  type        = "zip"
  source_dir  = "${path.module}/CreateEC2"
  output_path = "${path.module}/tmp/CreateEC2.zip"
}

resource "aws_lambda_function" "Lambda-CreateEC2" {

  function_name = "${var.aws_project}-Lambda-CreateEC2"
  description   = "Lambda-Python"
  filename      = data.archive_file.Lambda-CreateEC2-Archive.output_path
  runtime       = "python3.8"
  role          = aws_iam_role.Lambda-CreateEC2-Role.arn
  handler       = "lambda_function.lambda_handler"
  timeout       = 30
  publish       = false

  environment {
    variables = {
      "AMI"           = var.AMI
      "INSTANCE_TYPE" = var.INSTANCE_TYPE
      "KEY_NAME"      = var.KEY_NAME
      "SUBNET_ID"     = var.SUBNET_ID
    }
  }

  tags = merge(
    var.project_tags,
    {
      project = var.aws_project
    }
  )
}

resource "aws_cloudwatch_log_group" "Lambda-CreateEC2-LogGroup" {
  name              = "/aws/lambda/${var.aws_project}-Lambda-CreateEC2"
  retention_in_days = 3

  tags = merge(
    var.project_tags,
    {
      project = var.aws_project
    }
  )
}

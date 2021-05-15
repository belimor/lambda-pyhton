#######################
# Lambda-Python
#######################

data "archive_file" "Lambda-Archive" {
  type        = "zip"
  source_dir = "${path.module}/HelloWorld"
  output_path = "${path.module}/tmp/HelloWorld.zip"
}

resource "aws_lambda_function" "Lambda-Python" {

  function_name = "${var.project}-Lambda-Python"
  description   = "Lambda-Python"
  filename      = data.archive_file.Lambda-Archive.output_path
  runtime       = "python3.7"
  role          = aws_iam_role.Lambda-Role.arn
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
    var.custom_tags,
    {
      project = var.project
    }
  )
}

resource "aws_cloudwatch_log_group" "Lambda-Log-Group" {
  name              = "/aws/lambda/${var.project}-Lambda-Python"
  retention_in_days = 3

  tags = merge(
    var.custom_tags,
    {
      project = var.project
    }
  )
}

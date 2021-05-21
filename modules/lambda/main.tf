data "archive_file" "Lambda-Archive" {
  type        = "zip"
  source_dir  = "python/${var.function_name}"
  output_path = "tmp/${var.function_name}.zip"
}

resource "aws_lambda_function" "this" {
  function_name                  = var.function_name
  description                    = var.description
  role                           = aws_iam_role.Lambda-Role.arn
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

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy" "AWSLambdaBasicExecutionRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "lambda-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "Lambda-Role" {
  name                = "${var.aws_project}-Lambda-Role"
  assume_role_policy  = data.aws_iam_policy_document.lambda-assume-role-policy.json
  managed_policy_arns = [data.aws_iam_policy.AWSLambdaBasicExecutionRole.arn]

  tags = merge(
    var.project_tags,
    {
      project = var.aws_project
    }
  )
}

# resource "aws_iam_role_policy" "User-Lambda-Policy" {
#   name = "${var.aws_project}-User-Lambda-Policy"
#   role = aws_iam_role.Lambda-Role.id

#   policy = templatefile("${path.module}/policy/User-Lambda-Policy.tmpl", {
#     account_id = "${data.aws_caller_identity.current.account_id}",
#     region     = "${data.aws_region.current.name}",
#   })
# }

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

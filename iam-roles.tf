##############################
# IAM Roles
##############################

resource "aws_iam_role" "Lambda-CreateEC2-Role" {
  name = "${var.aws_project}-Lambda-CreateEC2-Role"
  #managed_policy_arns = [data.aws_iam_policy.AWSLambdaBasicExecutionRole.arn, ]

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "Lambda-CreateEC2-Policy" {
  name = "${var.aws_project}-Lambda-CreateEC2-Policy"
  role = aws_iam_role.Lambda-CreateEC2-Role.id

  policy = templatefile("${path.module}/lambda-CreateEC2-Policy.tmpl", {
    account_id = data.aws_caller_identity.current.account_id,
    region     = data.aws_region.current.name
  })
}

resource "aws_iam_role" "Lambda-StopEC2-Role" {
  name = "${var.aws_project}-Lambda-StopEC2-Role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "Lambda-StopEC2-Policy" {
  name = "${var.aws_project}-Lambda-StopEC2-Policy"
  role = aws_iam_role.Lambda-StopEC2-Role.id

  policy = templatefile("${path.module}/lambda-StopEC2-Policy.tmpl", {
    account_id = data.aws_caller_identity.current.account_id,
    region     = data.aws_region.current.name
  })
}

